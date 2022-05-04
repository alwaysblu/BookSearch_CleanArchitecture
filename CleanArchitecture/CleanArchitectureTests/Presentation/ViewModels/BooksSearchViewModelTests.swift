//
//  BooksSearchViewModelTests.swift
//  CleanArchitectureTests
//
//  Created by 최정민 on 2022/05/04.
//

import XCTest
@testable import CleanArchitecture

class BooksSearchViewModelTests: XCTestCase {
    
    let book = Book(title: "title 1",
                    authors: ["author 1"],
                    publishedDate: "publishedDate 1",
                    thumbnail: "thumbnail 1",
                    infoLink: "infoLink 1")
    lazy var bookPages = [BookPage(totalItems: 1, books: [book])]
    lazy var viewModel = BooksSearchItemViewModel(title: book.title, authors: book.authors, publishedDate: book.publishedDate, thumbnail: book.thumbnail)
    
    class SearchBooksUseCaseeMock: SearchBooksUseCase {
        var expectation: XCTestExpectation?
        var error: Error?
        var page = BookPage(totalItems: 1, books: [Book(title: "title 1",
                                                        authors: ["author 1"],
                                                        publishedDate: "publishedDate 1",
                                                        thumbnail: "thumbnail 1",
                                                        infoLink: "infoLink 1")])
        
        func search(request: SearchBooksUseCaseRequest,
                    completion: @escaping (Result<BookPage, Error>) -> Void) -> Cancellable? {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(page))
            }
            expectation?.fulfill()
            return nil
        }
    }
    
    func test_whenItemsCount가잘설정되는지확인하는경우_thenItemsCount는1개() {
        // given
        let searchMoviesUseCaseMock = SearchBooksUseCaseeMock()
        searchMoviesUseCaseMock.expectation = self.expectation(description: "itemsCount == 1")
        let viewModel = DefaultBooksSearchViewModel(useCase: searchMoviesUseCaseMock, actions: BooksSearchViewModelActions(showBookDetails: {_ in}))
        // when
        viewModel.didSearch(query: "title")
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.itemsCount, 1)
    }
    
}
