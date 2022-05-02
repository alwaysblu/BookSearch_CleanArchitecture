//
//  SearchBooksUseCaseTests.swift
//  CleanArchitectureTests
//
//  Created by 최정민 on 2022/05/02.
//

import XCTest

class SearchBooksUseCaseTests: XCTestCase {
    
    static let booksPages: [BooksPage] = {
        let page1 = BooksPage(page: 1, totalPages: 2, books: [
            Book(thumbNailUrl: "1", title: "title1", date: nil, description: "overview1"),
                                Book(thumbNailUrl: "2", title: "title2", date: nil, description: "overview2")])
        let page2 = BooksPage(page: 2, totalPages: 2, books: [
                                Book(thumbNailUrl: "3", title: "title3", date: nil, description: "overview3")])
        return [page1, page2]
    }()
    
    enum BooksRepositorySuccessTestError: Error {
        case failedFetching
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
