//
//  URLImageViewModel.swift
//  FreshWorks
//
//  Created by AftabAhmed on 28/06/22.
//

import SwiftUI
import UIKit

class URLImageViewModel: ObservableObject {
    
    var url: URL?
    var id: String?
    
    init(id: String?, url: URL?) {
        self.id = id
        self.url = url
    }
    
    @Environment(\.imageLoader) private var imageLoader
    
    @Published var data: Data? = nil
    @State private var err: Error? = nil
    
    func fetch() {
        Task {
            [weak self] in
            guard let self = self else {
                return
            }
            if let url = url, let id = id {
                do {
                    let imageFetched = try await imageLoader.fetch(url, id)
                    DispatchQueue.main.async {
                        self.data = imageFetched
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

enum GIFErrors: Error {
    case wrongUrl
}
