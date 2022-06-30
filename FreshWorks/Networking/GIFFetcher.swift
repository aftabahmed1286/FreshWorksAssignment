//
//  GIFFetcher.swift
//  FreshWorks
//
//  Created by AftabAhmed on 27/06/22.
//

import Foundation

/// This struct helps in fetching the image
struct GIFFetcher {
    
    var session = URLSession.shared
    
    func fetchGIF() async throws -> [GIFImageData]? {
        guard let fetchUrl = URL(string: URLBuilder.gifFetch()) else {
            fatalError("Missing URL")
        }
        let (data, response) = try await session.data(from: fetchUrl)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data")
        }
        
        let decoder = JSONDecoder()
        let gifModel = try decoder.decode(GIFModel.self, from: data)
        return gifModel.data?.map{
            GIFImageData(id: $0.id, url: URL(string: $0.images?.fixed_height?.url ?? ""))
        }
    }
}
















