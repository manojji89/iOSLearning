//
//  MovieCollectionView.swift
//  MovieDBApp
//
//  Created by Manoj Singhal on 14/03/21.
//

import UIKit
import Nuke

class MovieCollectionViewCell: UICollectionViewCell {
    
    private enum Config {
        static let cornerRadius = CGFloat(4)
        static var nukeOptions  = {
            ImageLoadingOptions(
                placeholder : UIImage.init(asset: .placeHolderImage),
                failureImage: nil,
                contentModes: ImageLoadingOptions.ContentModes(
                    success    : .scaleAspectFill,
                    failure    : .center,
                    placeholder: .center
                )
            )
        }()
    }
    
    
    @IBOutlet weak var imagePoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = Config.cornerRadius
    }
    
    func loadView(movie: PopularMovieModel.ViewModel.Movie) {
        if let poster = movie.poster {
            Nuke.loadImage(with: poster, options: Config.nukeOptions, into: imagePoster)
        } else {
            imagePoster.contentMode = .center
            imagePoster.image = nil
        }
    }
    
}
