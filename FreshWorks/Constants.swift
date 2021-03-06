//
//  Constants.swift
//  FreshWorks
//
//  Created by AftabAhmed on 25/06/22.
//

import Foundation

/// App Constants
enum GAC {
    static let apiKey = "nLonTtGp4NYxDNBnVTNGknvNRFnShBMT"
    
    static let baseUrl = "https://api.giphy.com/v1/gifs/"
    
    static let apiKeyText   = "api_key="
    static let limit25      = "limit=25"
    static let offset0      = "offset=0"
    static let ratingG      = "rating=g"
    static let langEn       = "lang=en"
}

/// API Path Constants
enum GIFAPIPath {
    static let search = "search"
    static let fetch = "trending"
}
