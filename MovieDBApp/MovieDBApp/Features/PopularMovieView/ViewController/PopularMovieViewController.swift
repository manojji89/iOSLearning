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
    
    private var viewModel = PopularMovieModel.ViewModel(movies: [], searchMovies: []) {
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

    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationUI()
        setupCollectionView()
        popularMovieCollectionView.reloadData()
        output.fetchMovies(PopularMovieModel.Request(movieCategoryType: .popular))
    }
    
    private func setupCollectionView() {
        view.addSubview(popularMovieCollectionView)
        popularMovieCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popularMovieCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        popularMovieCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        popularMovieCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
      
    private func setupNavigationUI() {
        title = "Popular Movies".localized
        sortByButton.setImage(UIImage.init(asset: .sortIconImage), for: .normal)
        sortByButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        sortByButton.translatesAutoresizingMaskIntoConstraints = false
        sortByButton.addTarget(self, action: #selector(sortByAction), for: UIControl.Event.touchUpInside)
        let barButton = UIBarButtonItem.init(customView: sortByButton)
        navigationItem.rightBarButtonItem = barButton

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.isActive = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
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

//MARK:- UICollectionView DataSourse
extension PopularMovieViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchActive ? viewModel.searchMovies.count : viewModel.movies.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.loadView(movie: searchActive ? viewModel.searchMovies[indexPath.row] : viewModel.movies[indexPath.row])
        return cell
    }
    
}

//MARK:- UICollectionView Flow Layout
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

//MARK:- Show/Hide loader, handle result and errors
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

//MARK:- UISearchResults
extension PopularMovieViewController: UISearchResultsUpdating {
    
  func updateSearchResults(for searchController: UISearchController) {
    if let text = searchController.searchBar.text, text.count > 0 {
        searchActive = true
        viewModel.searchMovies = viewModel.movies.filter({$0.title.contains(text)})
    } else {
        searchActive = false
        viewModel.searchMovies = []
    }
  }
    
}


