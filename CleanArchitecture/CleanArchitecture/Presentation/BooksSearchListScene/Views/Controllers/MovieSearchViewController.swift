//
//  BooksSearchViewController.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/29.
//

import UIKit

final class BooksSearchViewController: UIViewController {
    
    private let searchBarController = UISearchController()
    let emptyLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BookListCell.classForCoder(), forCellReuseIdentifier: BookListCell.identifier)
        
        return tableView
    }()
    private var viewModel: BooksSearchViewModel!
    
    static func create(viewModel: BooksSearchViewModel) -> BooksSearchViewController {
        let booksSearchViewController = BooksSearchViewController()
        booksSearchViewController.viewModel = viewModel
        return booksSearchViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUp()
    }
}

extension BooksSearchViewController {
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

extension BooksSearchViewController: UITableViewDelegate {
    
}

extension BooksSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookListCell.identifier, for: indexPath) as? BookListCell else {
            return UITableViewCell()
        }
        
        cell.configure(viewModel: viewModel.items[indexPath.row])
        
        return cell
    }
}

extension BooksSearchViewController: UISearchControllerDelegate {
    public func willPresentSearchController(_ searchController: UISearchController) {
        
    }

    public func willDismissSearchController(_ searchController: UISearchController) {
        
    }

    public func didDismissSearchController(_ searchController: UISearchController) {
        
    }
}