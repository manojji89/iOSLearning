//
//  MovieAPIConstants.swift
//  MovieDBApp
//
//  Created by Manoj Singhal on 14/03/21.
//

import Foundation

struct MovieAPIConstants {
    
    struct TMDB {
        private static let apiUrl = "https://api.themoviedb.org/"
        private static let apiVer = "3"
        static let apiKey = { () -> String in
            var apiKey = ""
            
            if let path = Bundle.main.path(forResource: "TMDB", ofType: "plist"),
               let data = NSDictionary(contentsOfFile: path) as? [String: Any] {
                
                apiKey = data["API_KEY"] as? String ?? ""
            }
            
            if apiKey.isEmpty { fatalError("Missing API Key") }
            
            return apiKey
        }()
        
        
        static let baseUrl      = try! "\(apiUrl)\(apiVer)".asURL()
        static let regionCode   = Locale.current.regionCode ?? "US"
        static let languageCode = "\(Locale.current.languageCode ?? "en")-\(regionCode)"
        
        
        enum ImageType {
            case poster
            
            var size: String {
                switch self {
                case .poster  : return "w500"
                }
            }
        }
        
        static let imgUrl = "https://image.tmdb.org/t/p/"
    }
    
}
