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
            let rating  : Double
            let poster  : String?
            let backdrop: String?
            let popularity: Double


            enum CodingKeys: String, CodingKey {
                case id
                case title
                case overview
                case rating   = "vote_average"
                case poster   = "poster_path"
                case backdrop = "backdrop_path"
                case popularity = "popularity"
            }
        }
    }
    
    struct ViewModel {
        var movies: [Movie]
        var searchMovies: [Movie]

        struct Movie {
            let id      : Int
            let title   : String
            let overview: String
            let rating  : Double
            let popularity: Double
            let poster  : URL?
        }
    }
    
}
