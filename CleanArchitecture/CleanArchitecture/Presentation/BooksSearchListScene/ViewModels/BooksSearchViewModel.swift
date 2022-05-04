//
//  BooksSearchViewModel.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import Foundation
import RxSwift

struct BooksSearchViewModelActions {
    let showBookDetails: (Book) -> Void
}

enum BooksListViewModelLoading {
    case fullScreen
    case nextPage
}

protocol BooksSearchViewModelInput {
    func didSearch(query: String)
    func didCancelSearch()
    func showBookDetails(at: Int)
    func didLoadNextPage()
}

protocol BooksSearchViewModelOutput {
    var itemsObserverable: PublishSubject<[BooksSearchItemViewModel]> { get }
    var loadingObservable: PublishSubject<BooksListViewModelLoading?> { get }
    var itemsCount: Int { get }
}

typealias BooksSearchViewModel = BooksSearchViewModelInput & BooksSearchViewModelOutput

final class DefaultBooksSearchViewModel: BooksSearchViewModel {
    private var totalItems: Int?
    private let maxResult: Int = 20
    private let useCase: SearchBooksUseCase
    private let actions: BooksSearchViewModelActions?
    private let disposBag = DisposeBag()
    var itemsObserverable = PublishSubject<[BooksSearchItemViewModel]>()
    var loadingObservable = PublishSubject<BooksListViewModelLoading?>()
    var itemsCount: Int = 0
    private var query: String = ""
    private var pages: [BookPage] = []
    private var loadTask: Cancellable? {
        willSet {
            loadTask?.cancel()
        }
    }
    
    enum BookPageListHandler {
        static func getViewModels(pages: [BookPage]) -> [BooksSearchItemViewModel] {
            return pages.flatMap{$0.books}.map (BooksSearchItemViewModel.init)
        }
        static func getBooks(pages: [BookPage]) -> [Book] {
            return pages.flatMap{$0.books}
        }
        
        static func getCountOfViewModels(pages: [BookPage]) -> Int {
            return getViewModels(pages: pages).count
        }
    }
    
    init(useCase: SearchBooksUseCase, actions: BooksSearchViewModelActions) {
        self.useCase = useCase
        self.actions = actions
    }
    
    private func update(bookQuery: BookQuery) {
        resetPages()
        load(bookQuery: bookQuery, loading: .fullScreen)
    }
}

extension DefaultBooksSearchViewModel {
    func showBookDetails(at index: Int) {
        let books = BookPageListHandler.getBooks(pages: pages)
        actions?.showBookDetails(books[index])
    }
    
    private func appendPage(_ booksPage: BookPage) {
        totalItems = booksPage.totalItems
        pages = pages + [booksPage]
        let items = BookPageListHandler.getViewModels(pages: pages)
        itemsCount = items.count
        itemsObserverable.onNext(items)
    }
    
    private func resetPages() {
        pages.removeAll()
        itemsObserverable.onNext([])
    }
    
    private func load(bookQuery: BookQuery,
                      loading: BooksListViewModelLoading) {
        guard totalItems == nil ||
                totalItems ?? 0 > BookPageListHandler.getCountOfViewModels(pages: pages) else {
            return
        }
        let totalItemsCount = BookPageListHandler.getCountOfViewModels(pages: pages)
        
        loadingObservable.onNext(loading)
        query = bookQuery.query
        
        loadTask = useCase.search (
            request: .init(query: bookQuery.query, startIndex: totalItemsCount, maxResult: maxResult)) { [weak self] result in
                switch result {
                case .success(let page):
                    self?.appendPage(page)
                case .failure(let error):
                    "\(error.localizedDescription)".log()
                }
                self?.loadingObservable.onNext(.none)
        }
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
    
    func didLoadNextPage() {
        load(bookQuery: .init(query: self.query),
             loading: .nextPage)
    }
}
