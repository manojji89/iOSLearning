//
//  UIFontExtension.swift
//  MovieDBApp
//
//  Created by Manoj Singhal on 14/03/21.
//

import Foundation

import UIKit.UIFont

/// Declare FontProtocol
protocol FontProtocol {
    func of(size: CGFloat) -> UIFont?
}

/// Add default implementation for FontProtocol
extension FontProtocol where Self: RawRepresentable, Self.RawValue == String {
    func of(size: CGFloat) -> UIFont? {
        return UIFont(name: rawValue, size: size)
    }
}

extension UIFont {
    
    /// HelveticaNeue adopts FontProtocol
    enum HelveticaNeue: String, FontProtocol {
        case regular         = "HelveticaNeue"
        case bold            = "HelveticaNeue-Bold"
        case boldCond        = "HelveticaNeue-BoldCond"      //Custom
        case condensed       = "HelveticaNeue-Condensed"     //Custom
        case condensedBold   = "HelveticaNeue-CondensedBold"
        case italic          = "HelveticaNeue-Italic"
        case medium          = "HelveticaNeue-Medium"
        case mediumCondensed = "HelveticaNeue-MediumCond"    //Custom
    }
}

// MARK: - Usage

//let font1 = UIFont.HelveticaNeue.regular.of(size: 12)!
