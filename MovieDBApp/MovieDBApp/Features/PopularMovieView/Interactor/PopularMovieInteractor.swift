//
//  PopularMovieInteractor.swift
//  MovieDBApp
//
//  Created by Manoj Singhal on 12/03/21.
//

import Foundation
import Combine
import Alamofire


protocol PopularMovieInteractorInput {
    func fetchMovies(_ request: PopularMovieModel.Request)
}

protocol PopularMovieInteractorOutput {
    func showLoading()
    func hideLoading()
    func showFailure(_ error: Error)
    func showSuccess(_ model: PopularMovieModel.ViewModel)
}

final class PopularMovieInteractor: PopularMovieInteractorInput {
    
    let output: PopularMovieInteractorOutput
    let worker: PopularMovieWorkerProtocol
    
    var cancellables = Set<AnyCancellable>()
    
    init(_ output: PopularMovieInteractorOutput, _ worker: PopularMovieWorkerProtocol) {
        self.output = output
        self.worker = worker
    }
    
    func fetchMovies(_ request: PopularMovieModel.Request) {
        output.showLoading()
        worker.fetchMovies(request.movieCategoryType)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error): self?.output.showFailure(error)
                    }
                },
                receiveValue: { [weak self] response in
                    let movies = response.results.map { entry -> PopularMovieModel.ViewModel.Movie in
                        return PopularMovieModel.ViewModel.Movie(
                            id      : entry.id,
                            title   : entry.title,
                            overview: entry.overview,
                            rating  : entry.rating,
                            poster  : entry.poster.map   { ApiRouter.getImageUrl(path: $0, forType: .poster) }
                        )
                    }
                
                    self?.output.hideLoading()
                    self?.output.showSuccess(PopularMovieModel.ViewModel(movies: movies))
                }
            )
            .store(in: &cancellables)
    }
    
}


protocol PopularMovieWorkerProtocol {
    func fetchMovies(_ categoryType: MovieCategoryType) -> AnyPublisher<PopularMovieModel.Response, AFError>
}

final class PopularMovieWorker: PopularMovieWorkerProtocol {
    
    func fetchMovies(_ categoryType: MovieCategoryType) -> AnyPublisher<PopularMovieModel.Response, AFError> {
        var route: Route
        
        switch categoryType {
        case .popular   : route = MovieAPIRouter.TMDB.popular
        }
        
        return ApiRouter.request(route, ofType: PopularMovieModel.Response.self)
    }
    
    
}
