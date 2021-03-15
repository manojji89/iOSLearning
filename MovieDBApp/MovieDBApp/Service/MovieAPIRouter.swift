//
//  MovieAPIRouter.swift
//  MovieDBApp
//
//  Created by Manoj Singhal on 14/03/21.
//

import Foundation
import Alamofire
import Combine

protocol Route: URLRequestConvertible {
    var method    : HTTPMethod  { get }
    var path      : String      { get }
    var parameters: Parameters? { get }
}

struct MovieAPIRouter : Route {
    var pageNumber : String

    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/movie/popular"
    }
    
    var parameters: Parameters? {
        return [
            "api_key" : MovieAPIConstants.TMDB.apiKey,
            "page"    : pageNumber
        ]
    }
    
    func asURLRequest() throws -> URLRequest {
        guard var components = URLComponents(
            url: MovieAPIConstants.TMDB.baseUrl.appendingPathComponent(self.path),
            resolvingAgainstBaseURL: false
        ) else { throw MovieAPIError.malformedUrl }
        
        if let parameters = self.parameters, !parameters.isEmpty {
            components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1 as? String) }
        }
        
        do {
            return try URLRequest(url: components.url!, method: self.method)
        } catch _ {
            throw MovieAPIError.malformedUrl
        }
    }
    
}

struct ApiRouter {
    
    static func request<T: Codable>(_ route: Route, ofType: T.Type) -> AnyPublisher<T, AFError> {
        return Deferred {
            Future { promise in
                AF.request(route).responseDecodable(of: ofType) { response in
                    promise(response.result)
                }
            }
        }.eraseToAnyPublisher()
    }
    
    static func getImageUrl(path: String, forType type: MovieAPIConstants.TMDB.ImageType) -> URL {
        return try! "\(MovieAPIConstants.TMDB.imgUrl)\(type.size)\(path)".asURL()
    }
    
}
