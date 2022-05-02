//
//  BooksSearchViewModel.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

protocol BooksSearchViewModelInput {
    func searchBooks(query: String)
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
    private(set) var items: [BooksSearchItemViewModel] = [
        BooksSearchItemViewModel(title: "title",
                                 overView: "overViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverViewoverView",
                                 releaseDate: "release Date",
                                 posterImageUrl: nil)]
    private var pages: [BooksPage] = []
    private var loadTask: Cancellable? {
        willSet {
            loadTask?.cancel()
        }
    }
    
    init(useCase: SearchBooksUseCase) {
        self.useCase = useCase
    }
}

extension DefaultBooksSearchViewModel {
    func searchBooks(query: String) {
        loadTask = useCase.search(request: .init(query: query, page: nextPage)) { [weak self] result in
            switch result {
            case .success(let response) :
                self?.appendPage(response)
            case .failure(let error) :
                "\(error)".log()
            }
        }
    }
    
    private func appendPage(_ booksPage: BooksPage) {
        currentPage = booksPage.page
        totalPage = booksPage.totalPages

        pages = pages
            .filter { $0.page != booksPage.page }
            + [booksPage]

        items = pages.flatMap{$0.books}.map(BooksSearchItemViewModel.init)
    }
    
    private func resetPages() {
        currentPage = 0
        totalPage = 1
        pages.removeAll()
        items.removeAll()
    }
}
