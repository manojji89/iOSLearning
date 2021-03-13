//
//  UIImageExtension.swift
//  MovieDBApp
//
//  Created by Manoj Singhal on 14/03/21.
//

import Foundation

import UIKit.UIImage

enum Asset: String {
    
    case placeHolderImage = "placeHolder"
    case failImage = "" // TODO: when image loading fails
    var image: UIImage {
        return UIImage(asset: self)
    }
}

extension UIImage {
    
    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
    
}

// MARK: - Usage

//let image1 = UIImage.init(asset: .profileIcon)
