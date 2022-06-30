//
//  URLBuilder.swift
//  FreshWorks
//
//  Created by AftabAhmed on 25/06/22.
//

import Foundation

/// This class builds the url strings for different APIs used in the app
class URLBuilder {
    
//    static let shared: URLBuilder = URLBuilder()
    
    /*
     https://api.giphy.com/v1/gifs/search?api_key=nLonTtGp4NYxDNBnVTNGknvNRFnShBMT&q=a&limit=25&offset=0&rating=g&lang=en
     */
    /// This method builds url string for the search API
    /// - Parameter query: String
    /// - Returns: String
    class func gifSearch(_ query: String) -> String {
        GAC.baseUrl
        + GIFAPIPath.search
        + "?" + GAC.apiKeyText + GAC.apiKey
        + "&q=" + query
        + "&" + GAC.limit25
        + "&" + GAC.offset0
        + "&" + GAC.ratingG
        + "&" + GAC.langEn
    }
    
    /*
     https://api.giphy.com/v1/gifs/trending?api_key=nLonTtGp4NYxDNBnVTNGknvNRFnShBMT&limit=25&rating=g
     */
    /// This method builds url string for the fetch API
    /// - Returns: String
    class func gifFetch() -> String {
        GAC.baseUrl
        + GIFAPIPath.fetch
        + "?" + GAC.apiKeyText + GAC.apiKey
        + "&" + GAC.limit25
        + "&" + GAC.ratingG
    }
    
}




