//
//  StringExtension.swift
//  MovieDBApp
//
//  Created by Manoj Singhal on 14/03/21.
//

import Foundation

// Mark: - To support Localization

extension String {
    
    /// Localized value of String
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// Localized value of String
    ///
    /// - Parameters:
    ///   - comment: comment for localized String.
    func localized(_ comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
