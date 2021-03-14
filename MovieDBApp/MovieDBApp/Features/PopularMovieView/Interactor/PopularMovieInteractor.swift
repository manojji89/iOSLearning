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
    func sortMovies(sortType: SortBy)
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
    var viewModel: PopularMovieModel.ViewModel
    
    var cancellables = Set<AnyCancellable>()
    
    init(_ output: PopularMovieInteractorOutput, _ worker: PopularMovieWorkerProtocol, _ viewModel: PopularMovieModel.ViewModel) {
        self.output = output
        self.worker = worker
        self.viewModel = viewModel
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
                    var movies = response.results.map { entry -> PopularMovieModel.ViewModel.Movie in
                        return PopularMovieModel.ViewModel.Movie(
                            id      : entry.id,
                            title   : entry.title,
                            overview: entry.overview,
                            rating  : entry.rating, popularity: entry.popularity,
                            poster  : entry.poster.map   { ApiRouter.getImageUrl(path: $0, forType: .poster) }
                        )
                    }
                    
                    movies = (movies.sorted(by: {
                        $0.popularity < $1.popularity
                    }))
                
                    self?.output.hideLoading()
                    self?.viewModel = PopularMovieModel.ViewModel(movies: movies, searchMovies: [])
                    self?.output.showSuccess(self!.viewModel)
                }
            )
            .store(in: &cancellables)
    }
    
    /// Sort movies against movie popularity or movie rating.
    /// On finish, update moviest
    func sortMovies(sortType: SortBy) {
        switch sortType {
        case .mostPopular:
            viewModel.movies = viewModel.movies.sorted(by: {
                $0.popularity < $1.popularity
            })
        case .highestRated:
            viewModel.movies = viewModel.movies.sorted(by: {
                $0.rating < $1.rating
            })
        default: break
        }
        self.output.showSuccess(self.viewModel)
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
