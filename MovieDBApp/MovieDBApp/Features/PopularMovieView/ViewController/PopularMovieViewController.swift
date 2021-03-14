//
//  PopularMovieViewController.swift
//  MovieDBApp
//
//  Created by Manoj Singhal on 11/03/21.
//

import UIKit

class PopularMovieViewController: UIViewController, SortViewControllerDelegate {
    
    lazy var popularMovieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(MovieCollectionViewCell.nib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return view
    }()
    
    
    lazy var activityIndicator: UIActivityIndicatorView =  {
        let loader = UIActivityIndicatorView(style: .large)
        loader.center = view.center
        loader.hidesWhenStopped = true
        view.addSubview(loader)
        return loader
    }()

    
    private(set) lazy var output: PopularMovieInteractorInput = {
        return PopularMovieInteractor(PopularMoviePresenter(self) as PopularMovieInteractorOutput, PopularMovieWorker(), viewModel)
    }()
    
    private var viewModel = PopularMovieModel.ViewModel(movies: []) {
        didSet {
            popularMovieCollectionView.reloadData()
        }
    }
    
    fileprivate enum UIConstants {
        static let margin: CGFloat = 15.0
        static let itemSizeRatio: CGFloat = 2.0/3.0
    }
    
    private var itemSize: CGSize = .zero
        
    private let sortByButton = UIButton(type: .custom)
    
    private var sortBy: SortBy = .mostPopular

    private struct Const {
      /// Image height/width for Large NavBar state
      static let ImageSizeForLargeState: CGFloat = 30
      /// Margin from right anchor of safe area to right anchor of Image
      static let ImageRightMargin: CGFloat = 16
      /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
      static let ImageBottomMarginForLargeState: CGFloat = 12
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationUI()
        view.addSubview(popularMovieCollectionView)
        popularMovieCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popularMovieCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        popularMovieCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        popularMovieCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        popularMovieCollectionView.reloadData()
        output.fetchMovies(PopularMovieModel.Request(movieCategoryType: .popular))
    }
      
    private func setupNavigationUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Popular Movies".localized
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.addSubview(sortByButton)
        sortByButton.setImage(UIImage.init(asset: .sortIconImage), for: .normal)
        sortByButton.translatesAutoresizingMaskIntoConstraints = false
        sortByButton.addTarget(self, action: #selector(sortByAction), for: UIControl.Event.touchUpInside)
        NSLayoutConstraint.activate([
            sortByButton.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
            sortByButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
            sortByButton.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            sortByButton.widthAnchor.constraint(equalTo: sortByButton.heightAnchor)
        ])
    }
    
    
    @objc func sortByAction() {
        let controller = SortViewController()
        controller.sortBy = sortBy
        controller.delegate = self
        controller.modalPresentationStyle = .custom
        let nav = UINavigationController(rootViewController: controller)
        nav.navigationBar.isHidden = true
        present(nav, animated: true, completion: nil)
        // Present Search Controller
    }

    func sortBy(option: SortBy) {
        self.sortBy = option
        output.sortMovies(sortType: self.sortBy)
    }

}

extension PopularMovieViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.loadView(movie: viewModel.movies[indexPath.row])
        return cell
    }
    
}


extension PopularMovieViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIConstants.margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.bounds.width - 3*UIConstants.margin)/2)
        return CGSize(width: width , height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: UIConstants.margin, left: UIConstants.margin, bottom: UIConstants.margin, right: UIConstants.margin)
    }
    
}


extension PopularMovieViewController: PopularMoviePresenterOutput {
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    func showFailure(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: "Hmmm… something went wrong. Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSuccess(_ model: PopularMovieModel.ViewModel) {
        viewModel = model
    }
    
}


