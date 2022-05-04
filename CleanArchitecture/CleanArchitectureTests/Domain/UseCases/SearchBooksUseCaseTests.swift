//
//  SearchBooksUseCaseTests.swift
//  CleanArchitectureTests
//
//  Created by 최정민 on 2022/05/02.
//

import XCTest
@testable import CleanArchitecture

class SearchBooksUseCaseTests: XCTestCase {
    
    static let booksPage: BookPage = {
        return BookPage(totalItems: 3,
                             books: [
                                Book(title: "title 1",
                                     authors: ["author 1"],
                                     publishedDate: "publishedDate 1",
                                     thumbnail: "thumbnail 1",
                                     infoLink: "infoLink 1"),
                                Book(title: "title 2",
                                     authors: ["author 2"],
                                     publishedDate: "publishedDate 2",
                                     thumbnail: "thumbnail 2",
                                     infoLink: "infoLink 2"),
                             ])
    }()
    
    enum BooksRepositorySuccessTestError: Error {
        case failedFetching
    }
    
    struct BooksRepositoryMock: BooksRepository {
        var result: Result<BookPage, Error>
        
        func fetchBooks(query: String, startIndex: Int, maxResults: Int, completion: @escaping (Result<BookPage, Error>) -> Void) -> Cancellable? {
            completion(result)
            return nil
        }
    }
    
    func testSearchBooksUseCase_when패치테스트성공하는경우_then컴플리션핸들러Result가Success이어야함() {
        // given
        let expectation = self.expectation(description: "Search Success")
        expectation.expectedFulfillmentCount = 1
        let booksRepository = BooksRepositoryMock(result: .success(SearchBooksUseCaseTests.booksPage))
        let useCase = DefaultSearchBooksUseCase(booksRepository: booksRepository)
        let requestValue = SearchBooksUseCaseRequest(query: "test",
                                                     startIndex: 0,
                                                     maxResult: 2)
        
        // when
        _ = useCase.search(request: requestValue) { result in
            let response = (try? result.get())
            guard response != nil else { return }
            expectation.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchBooksUseCase_when패치테스트실패하는경우_then컴플리션핸들러Result가Fail이어야함() {
        // given
        let expectation = self.expectation(description: "Search Fail")
        expectation.expectedFulfillmentCount = 1
        let booksRepository = BooksRepositoryMock(result: .failure(BooksRepositorySuccessTestError.failedFetching))
        let useCase = DefaultSearchBooksUseCase(booksRepository: booksRepository)
        let requestValue = SearchBooksUseCaseRequest(query: "test",
                                                     startIndex: 0,
                                                     maxResult: 2)
        
        // when
        _ = useCase.search(request: requestValue) { result in
            let response = (try? result.get())
            guard response != nil else {
                expectation.fulfill()
                return
            }
        }
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
    }
}
