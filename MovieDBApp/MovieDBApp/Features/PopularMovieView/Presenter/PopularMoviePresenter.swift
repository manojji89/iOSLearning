//
//  PopularMoviePresenter.swift
//  MovieDBApp
//
//  Created by Manoj Singhal on 12/03/21.
//

import Foundation

protocol PopularMoviePresenterOutput {
    func showLoading()
    func hideLoading()
    func showFailure(_ error: Error)
    func showSuccess(_ model: PopularMovieModel.ViewModel)
    func showSortedData(_ model: PopularMovieModel.ViewModel)
}

final class PopularMoviePresenter: PopularMovieInteractorOutput {
    
    let output: PopularMoviePresenterOutput
    
    init(_ output: PopularMoviePresenterOutput) {
        self.output = output
    }

    func showLoading() { output.showLoading() }
    
    func hideLoading() { output.hideLoading() }

    func showFailure(_ error: Error) {
        output.showFailure(error)
    }

    func showSuccess(_ model: PopularMovieModel.ViewModel) {
        output.showSuccess(model)
    }
    
    func showSortedData(_ model: PopularMovieModel.ViewModel) {
        output.showSortedData(model)
    }
}
