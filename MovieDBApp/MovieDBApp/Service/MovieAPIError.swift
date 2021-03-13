//
//  MovieMovieAPIError.swift
//  MovieDBApp
//
//  Created by Manoj Singhal on 14/03/21.
//

import Foundation


enum MovieAPIError: Error {
    case missingApiKey
    case malformedUrl
}
