//
//  GIFModel.swift
//  FreshWorks
//
//  Created by AftabAhmed on 27/06/22.
//

import Foundation
import SwiftUI

/// This is the model to store the data when downloaded from the server
struct GIFModel: Codable {
    //Data Related
    struct FixedHeight: Codable {
        let url: String?
    }
    
    struct Images: Codable {
        let fixed_height: FixedHeight?
    }
    
    struct GIFData: Codable {
        let id: String?
        let images: Images?
    }
    
    //Pagination Related
    struct GIFPagination: Codable {
        let total_count: Int?
        let count: Int?
        let offset: Int?
    }
    
    //Meta Related
    struct GIFMeta: Codable {
        let status: Int?
        let msg: String?
        let response_id: String?
    }
    
    var data: [GIFData]?
    var pagination: GIFPagination?
    var meta: GIFMeta?
}

/// This is the model used in the app throughout
struct GIFImageData: Hashable, Codable {
    let id: String?
    let url: URL?
}
