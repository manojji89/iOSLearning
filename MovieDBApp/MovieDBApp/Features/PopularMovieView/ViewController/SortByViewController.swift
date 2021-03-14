//
//  SortByViewController.swift
//  MovieDBApp
//
//  Created by Manoj Singhal on 14/03/21.
//

import Foundation
import UIKit

@objc enum SortBy: Int {
    case mostPopular = 0
    case highestRated
    
    init?(index: Int) {
        switch index {
        case 0: self = .mostPopular
        case 1: self = .highestRated
        default:
            return nil
        }
    }
    
    var description: String? {
        get {
            switch self {
            case .mostPopular: return "most popular"
            case .highestRated: return "highest rated"
            }
        }
    }
}

protocol SortViewControllerDelegate: class {
    func sortBy(option: SortBy)
}

class SortViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
                };
    }
    
 
    private var selectedIndexPath: NSIndexPath?
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.isScrollEnabled = false
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        headerView.backgroundColor = .placeholderText
        
        let sortByLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 100, height: 40))
        sortByLabel.textAlignment = .left
        sortByLabel.font = UIFont.HelveticaNeue.condensedBold.of(size: 14)
        sortByLabel.text = "SORT BY"
        
        
        let closeButton = UIButton(frame: CGRect(x: self.view.frame.width - 40, y: 0 , width: 40, height: 40))
        closeButton.setImage(UIImage.init(asset: .closeIconImage), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: UIControl.Event.touchUpInside)

        headerView.addSubview(closeButton)
        
        
        headerView.addSubview(sortByLabel)
        view.tableHeaderView = headerView
        
        view.register(UITableViewCell.self, forCellReuseIdentifier: "SortCell")

        return view
    }()
    
    weak var delegate: SortViewControllerDelegate?
    
    var sortBy: SortBy = .mostPopular

    @objc func closeButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension SortViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        if let path = selectedIndexPath, indexPath != path as IndexPath {
            if let sortOption = SortBy(index: indexPath.row) {
                delegate?.sortBy(option: sortOption)
            }
            dismiss(animated: true, completion: nil)
        }
    }

}

extension SortViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortCell", for: indexPath)
        cell.selectionStyle = .none
        if let sortOption = SortBy(index: indexPath.row) {
            cell.textLabel?.text = sortOption.description
            if sortOption == sortBy {
                cell.accessoryType = .checkmark
                selectedIndexPath = indexPath as NSIndexPath
            }
        }
        
        return cell

    }
    
}
