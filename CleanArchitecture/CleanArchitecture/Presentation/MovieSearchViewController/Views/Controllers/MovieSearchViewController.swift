//
//  MoviewSearchViewController.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/29.
//

import UIKit

final class MovieSearchViewController: UIViewController {
    
    private let searchBarController = UISearchController()
    let emptyLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    private var viewModel: MovieSearchViewModel!
    
    static func create(viewModel: MovieSearchViewModel) -> MovieSearchViewController {
        let movieSearchViewController = MovieSearchViewController()
        movieSearchViewController.viewModel = viewModel
        return movieSearchViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUp()
    }
}

extension MovieSearchViewController {
    private func setUp() {
        setUpSearchBarController()
        setAllDelegates()
        addAllSubviews()
        setAllConstraints()
    }
    
    private func addAllSubviews() {
        view.addSubview(tableView)
        view.addSubview(emptyLabel)
    }
    
    private func setAllDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpSearchBarController() {
        navigationItem.searchController = searchBarController
        searchBarController.delegate = self
    }
}

extension MovieSearchViewController: UITableViewDelegate {
    
}

extension MovieSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.identifier, for: indexPath) as? MovieListCell else {
            return UITableViewCell()
        }
        
        cell.configure(viewModel: viewModel.items[indexPath.row])
        
        return cell
    }
}

extension MovieSearchViewController: UISearchControllerDelegate {
    public func willPresentSearchController(_ searchController: UISearchController) {
        
    }

    public func willDismissSearchController(_ searchController: UISearchController) {
        
    }

    public func didDismissSearchController(_ searchController: UISearchController) {
        
    }
}
