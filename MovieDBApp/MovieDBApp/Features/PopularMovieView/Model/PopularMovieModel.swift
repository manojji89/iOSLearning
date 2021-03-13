//
//  PopularMovieModel.swift
//  MovieDBApp
//
//  Created by Manoj Singhal on 12/03/21.
//

import Foundation


enum MovieCategoryType {
    case popular
}

struct PopularMovieModel {
    
    struct Request {
        let movieCategoryType: MovieCategoryType
    }
    
    struct Response: Codable {
        let results: [Movie]
        
        struct Movie: Codable {
            let id      : Int
            let title   : String
            let overview: String
            let rating  : Float?
            let poster  : String?
            let backdrop: String?

            enum CodingKeys: String, CodingKey {
                case id
                case title
                case overview
                case rating   = "vote_average"
                case poster   = "poster_path"
                case backdrop = "backdrop_path"
            }
        }
    }
    
    struct ViewModel {
        let movies: [Movie]
        
        struct Movie {
            let id      : Int
            let title   : String
            let overview: String
            let rating  : Float?
            let poster  : URL?
        }
    }
    
}
