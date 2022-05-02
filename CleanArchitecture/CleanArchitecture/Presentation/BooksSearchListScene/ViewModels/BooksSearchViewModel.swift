//
//  BooksSearchViewModel.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

enum BooksListViewModelLoading {
    case fullScreen
    case nextPage
}

protocol BooksSearchViewModelInput {
    func searchBooks(query: String)
    func didSearch(query: String)
    func didCancelSearch()
    var onUpdated: () -> Void { get set }
}

protocol BooksSearchViewModelOutput {
    var items: [BooksSearchItemViewModel] { get }
}
typealias BooksSearchViewModel = BooksSearchViewModelInput & BooksSearchViewModelOutput

final class DefaultBooksSearchViewModel: BooksSearchViewModel {
    private var currentPage: Int = 0
    private var totalPage: Int = 1
    private var nextPage: Int { currentPage < totalPage ? currentPage + 1 : currentPage }
    private let useCase: SearchBooksUseCase
    var onUpdated: () -> Void = {}
    private(set) var items: [BooksSearchItemViewModel] = [] {
        didSet {
            onUpdated()
        }
    }
    private var pages: [BookPage] = []
    private var loadTask: Cancellable? {
        willSet {
            loadTask?.cancel()
        }
    }
    
    init(useCase: SearchBooksUseCase) {
        self.useCase = useCase
    }
    
    private func update(bookQuery: BookQuery) {
        resetPages()
        load(bookQuery: bookQuery, loading: .fullScreen)
    }
}

extension DefaultBooksSearchViewModel {
    func searchBooks(query: String) {
        loadTask = useCase.search(request: .init(query: query, startIndex: 0, maxResult: 10)) { [weak self] result in
            switch result {
            case .success(let response) :
                self?.appendPage(response)
            case .failure(let error) :
                "\(error)".log()
            }
        }
    }
    
    private func appendPage(_ booksPage: BookPage) {
        currentPage = booksPage.page
        totalPage = booksPage.totalPages

        pages = pages
            .filter { $0.page != booksPage.page }
            + [booksPage]

        items = pages.flatMap{$0.books}.map (BooksSearchItemViewModel.init)
    }
    
    private func resetPages() {
        currentPage = 0
        totalPage = 1
        pages.removeAll()
        items.removeAll()
    }
    
    private func load(bookQuery: BookQuery,
                      loading: BooksListViewModelLoading) {
//        self.loading.value = loading
//        query.value = bookQuery.query

        loadTask = useCase.search (
            request: .init(query: bookQuery.query, startIndex: 0, maxResult: 40),
            completion: { result in
                switch result {
                case .success(let page):
                    self.appendPage(page)
                case .failure(let error):
                    "\(error)".log()
                }
//                self.loading.value = .none
        })
    }
    
}

extension DefaultBooksSearchViewModel {
    func didSearch(query: String) {
        guard !query.isEmpty else { return }
        update(bookQuery: BookQuery(query: query))
    }

    func didCancelSearch() {
        loadTask?.cancel()
    }
}
