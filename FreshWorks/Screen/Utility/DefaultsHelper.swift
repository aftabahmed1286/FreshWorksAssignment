//
//  DefaultsHelper.swift
//  FreshWorks
//
//  Created by AftabAhmed on 29/06/22.
//

import Foundation


/// This class helps in storing the values to UserDefaults
class DefaultsHelper {
    static let defaults = UserDefaults.standard
    
    /// This method helps in fetching bool value against the provided key
    /// - Parameter key: String
    /// - Returns: Bool
    static func isFavoriteFor(_ key: String) -> Bool {
        defaults.bool(forKey: key)
    }
    
    /// This method helps in adding a bool value for the provided key
    /// - Parameters:
    ///   - key: String
    ///   - shouldFav: Bool
    static func shouldfavoriteFor(_ key: String, shouldFav: Bool) {
        defaults.set(shouldFav, forKey: key)
    }
}
