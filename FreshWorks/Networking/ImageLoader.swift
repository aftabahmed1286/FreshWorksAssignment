//
//  ImageLoader.swift
//  FreshWorks
//
//  Created by AftabAhmed on 27/06/22.
//

import SwiftUI

struct ImageLoaderKey: EnvironmentKey {
    static let defaultValue = ImageLoader()
}

extension EnvironmentValues {
    var imageLoader: ImageLoader {
        get { self[ImageLoaderKey.self] }
        set { self[ImageLoaderKey.self ] = newValue}
    }
}

actor ImageLoader {
    
    private enum LoaderStatus {
        case inProgress(Task<Data, Error>)
        case fetched(Data)
    }
    
    private var images: [String: LoaderStatus] = [:]

    public func fetch(_ url: URL, _ id: String) async throws -> Data {
        let request = URLRequest(url: url)
        return try await fetch(request, id)
    }

    public func fetch(_ urlRequest: URLRequest, _ id: String) async throws -> Data {
        // fetch image by URLRequest
        if let status = images[id] {
            switch status {
            case .fetched(let data):
                print("Image from Fetched - \(id)")
                return data
            case .inProgress(let task):
                return try await task.value
            }
        }
        
        //Fetch image from file system
        if let image = self.imageFromFileSystem(for: id) {
            images[id] = .fetched(image)
            print("Image from FileSystem - \(id)")
            return image
        }
        
        //Fetch image over network
        let task: Task<Data, Error> = Task {
            let (imageData, _) = try await URLSession.shared.data(for: urlRequest)
//            let image = UIImage(data: imageData)!
            try self.persistImage(imageData, for: id)
            return imageData
        }
        
        images[id] = .inProgress(task)
        let image = try await task.value
        images[id] = .fetched(image)
        print("Image from network - \(id)")
        return image
    }
    
    private func persistImage(_ data: Data, for id: String) throws {
        guard let url = fileName(for: id)
                //,
              //let data = image.jpegData(compressionQuality: 0.8)
        else {
            assertionFailure("Unable to generate a local path for \(id)")
            return
        }

        try data.write(to: url)
    }

    private func imageFromFileSystem(for id: String) -> Data? {
        guard let url = fileName(for: id) else {
            assertionFailure("Unable to generate a local path for \(id)")
            return nil
        }
        print("\(id) - \(url)")
        if let data = try? Data(contentsOf: url) {
            return data//UIImage(data: data)
        } else {
            return nil
        }
        
    }
    
    private func fileName(for id: String) -> URL? {
        guard let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return docDir.appendingPathComponent(id)
    }
}




