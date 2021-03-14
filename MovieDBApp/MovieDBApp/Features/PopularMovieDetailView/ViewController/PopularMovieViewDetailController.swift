//
//  PopularMovieViewDetailController.swift
//  MovieDBApp
//
//  Created by Manoj Singhal on 15/03/21.
//

import Foundation
import UIKit
import Nuke

class PopularMovieViewDetailController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var summaryLabel: UILabel!
        
    private enum Config {
        static let cornerRadius = CGFloat(4)
        static var nukeOptions  = {
            ImageLoadingOptions(
                placeholder : UIImage.init(asset: .placeHolderImage),
                failureImage: nil,
                contentModes: ImageLoadingOptions.ContentModes(
                    success    : .scaleAspectFit,
                    failure    : .center,
                    placeholder: .center
                )
            )
        }()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateUI(_ movie: PopularMovieModel.ViewModel.Movie) {
        if let _ = view {
            titleLabel.text = movie.title
            if let poster = movie.poster {
                Nuke.loadImage(with: poster, options: Config.nukeOptions, into: posterImageView)
            } else {
                posterImageView.contentMode = .center
                posterImageView.image = nil
            }
            scoreLabel.text =  "\(movie.rating) / 10"
            summaryLabel.text = movie.overview
            yearLabel.text = "Released: \(movie.releaseDate)"
        }
        
    }


}
