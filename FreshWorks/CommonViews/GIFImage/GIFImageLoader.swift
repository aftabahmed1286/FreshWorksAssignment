//
//  GIFImageLoader.swift
//  FreshWorks
//
//  Created by AftabAhmed on 29/06/22.
//

import SwiftUI

/// This class helps in downloading the image aynchronously
class GIFImageLoader: ObservableObject {
    
    var gifImageData: GIFImageData?
    
    @Published var image: Data?
    @Published var isFav = false
    
    @Published var err: Error?
    
    @Environment(\.imageLoader) private var imageLoader
    
    /// This method downloads the the image data asynchronously
    func fetch() {
        Task {
            [weak self] in
            guard let self = self else {
                return
            }
            if let url = gifImageData?.url, let id = gifImageData?.id {
                do {
                    let imageFetched = try await imageLoader.fetch(url, id)
                    DispatchQueue.main.async {
                        self.image = imageFetched
                        self.isFav = DefaultsHelper.isFavoriteFor(id)
                    }
                    print("Image Loaded - \(id)")
                } catch {
                    err = error
                    print(error)
                }
                
            } else {
                err = GIFErrors.wrongUrl
            }
        }
    }
}
