//
//  BooksSearchViewController.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/29.
//

import UIKit

final class BooksSearchViewController: UIViewController {
    var imageRepository: ImageRepository?
    private let searchController = UISearchController()
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
    
    static func create(viewModel: BooksSearchViewModel, imageRepository: ImageRepository) -> BooksSearchViewController {
        let booksSearchViewController = BooksSearchViewController()
        booksSearchViewController.viewModel = viewModel
        booksSearchViewController.imageRepository = imageRepository
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
        setupSearchController()
        viewModel.onUpdated = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        navigationItem.searchController = searchController
        searchController.delegate = self
    }
    
    private func setupSearchController() {
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchController.searchBar.barStyle = .black
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.autoresizingMask = [.flexibleWidth]
        definesPresentationContext = true
    }
}

extension BooksSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension BooksSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookListCell.identifier, for: indexPath) as? BookListCell else {
            return UITableViewCell()
        }
        
        cell.configure(viewModel: viewModel.items[indexPath.row], imageRepository: imageRepository)
        
        return cell
    }
}

extension BooksSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchController.isActive = false
        viewModel.didSearch(query: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.didCancelSearch()
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
