//
//  BooksSearchViewController.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/29.
//

import UIKit
import RxCocoa
import RxSwift

final class BooksSearchViewController: UIViewController {
    private var imageRepository: ImageRepository?
    private let searchController = UISearchController()
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BookListCell.classForCoder(), forCellReuseIdentifier: BookListCell.identifier)
        
        return tableView
    }()
    private var viewModel: BooksSearchViewModel!
    private let disposeBag = DisposeBag()
    private var nextPageLoadingSpinner: UIActivityIndicatorView?
    
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
    func updateLoading(_ loading: BooksListViewModelLoading?) {
        switch loading {
        case .nextPage:
            nextPageLoadingSpinner?.removeFromSuperview()
            nextPageLoadingSpinner = tableView.makeActivityIndicator(size: .init(width: tableView.frame.width, height: 44))
            tableView.tableFooterView = nextPageLoadingSpinner
        case .fullScreen:
            LoadingView.show()
            tableView.tableFooterView = nil
        case .none:
            LoadingView.hide()
        }
    }
    
    private func setUp() {
        setUpSearchBarController()
        setAllDelegates()
        addAllSubviews()
        setAllConstraints()
        setupSearchController()
        setObservable()
    }
    
    private func setObservable() {
        viewModel.itemsObserverable
            .bind(to: tableView.rx.items(cellIdentifier: BookListCell.identifier,
                                         cellType: BookListCell.self)) { [weak self] index, item, cell in
                cell.configure(viewModel: item, imageRepository: self?.imageRepository)
                if let itemsCount = self?.viewModel.itemsCount,
                   index == itemsCount - 1 {
                    self?.viewModel.didLoadNextPage()
                }
            }.disposed(by: disposeBag)
        
        viewModel.loadingObservable
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] loading in
                self?.updateLoading(loading)
            }.disposed(by: disposeBag)
    }
    
    private func addAllSubviews() {
        view.addSubview(tableView)
    }
    
    private func setAllDelegates() {
        tableView.delegate = self
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showBookDetails(at: indexPath.row)
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

extension BooksSearchViewController: UISearchControllerDelegate {}
