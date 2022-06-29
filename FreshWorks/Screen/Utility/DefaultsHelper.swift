//
//  DefaultsHelper.swift
//  FreshWorks
//
//  Created by AftabAhmed on 29/06/22.
//

import Foundation

class DefaultsHelper {
    static let defaults = UserDefaults.standard
    
    static func isFavoriteFor(_ key: String) -> Bool {
        defaults.bool(forKey: key)
    }
    
    static func shouldfavoriteFor(_ key: String, shouldFav: Bool) {
        defaults.set(shouldFav, forKey: key)
    }
}
