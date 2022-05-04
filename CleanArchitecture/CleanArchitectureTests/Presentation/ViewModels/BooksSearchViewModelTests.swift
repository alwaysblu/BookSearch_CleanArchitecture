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
    
    
    func testBookPageListHandler_whenBooksPageListHandler성공하는경우_then예상값과일치() {
        XCTAssertEqual(DefaultBooksSearchViewModel.BookPageListHandler.getBooks(pages: bookPages), [book])
        XCTAssertEqual(DefaultBooksSearchViewModel.BookPageListHandler.getViewModels(pages: bookPages), [viewModel])
        XCTAssertEqual(DefaultBooksSearchViewModel.BookPageListHandler.getCountOfViewModels(pages: bookPages), 1)
    }
    
    func testBookPageListHandler_whenBooksPageListHandler실패하는경우_then예상값과불일치() {
        XCTAssertNotEqual(DefaultBooksSearchViewModel.BookPageListHandler.getBooks(pages: bookPages), [])
        XCTAssertNotEqual(DefaultBooksSearchViewModel.BookPageListHandler.getViewModels(pages: bookPages), [])
        XCTAssertNotEqual(DefaultBooksSearchViewModel.BookPageListHandler.getCountOfViewModels(pages: bookPages), 2)
    }
    
    
    
}
