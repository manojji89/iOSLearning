//
//  PopularMovieRouter.swift
//  MovieDBApp
//
//  Created by Manoj Singhal on 12/03/21.
//

import Foundation

import UIKit

protocol PopularMovieRouting {
    func routeToDetails(movie: PopularMovieModel.ViewModel.Movie)
}

final class PopularMovieRouter: PopularMovieRouting {
    
    weak var controller: UIViewController?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func routeToDetails(movie: PopularMovieModel.ViewModel.Movie) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopularMovieViewDetailController") as! PopularMovieViewDetailController
        vc.updateUI(movie)
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
