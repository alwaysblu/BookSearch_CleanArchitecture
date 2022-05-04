//
//  NetworkTests.swift
//  CleanArchitectureTests
//
//  Created by 최정민 on 2022/05/04.
//

import XCTest
@testable import CleanArchitecture

class NetworkTests: XCTestCase {
    let apiURL = URL(string: AppConfiguration.apiBaseUrl)!
    var networkLoader: NetworkLoader!
    var expectation: XCTestExpectation!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self] // 프로토콜 클래스의 배열
        let urlSession = URLSession.init(configuration: configuration)
        networkLoader = DefaultNetworkLoader(session: urlSession)
    }
    
    func test_get_성공() {
        expectation = expectation(description: "Expectation")
        expectation.expectedFulfillmentCount = 1
        let response = BooksResponseDTO(totalItems: 1,
                                        items: [BooksResponseDTO.BookDTO(volumeInfo: BooksResponseDTO.VolumeInfo(title: "title",
                                                                                                                 authors: ["authors"],
                                                                                                                 publishedDate: "publishedDate",
                                                                                                                 imageLinks: nil,
                                                                                                                 infoLink: "infoLink"))])
        let data = try? JSONEncoder().encode(response)
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == self.apiURL else {
                // 헤더, HTTP 메서드 같은 component들도 확인할 수 있다.
                throw DataError.invalidURL
            }
            
            let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        // Call API.
        _ = networkLoader.loadData(with: apiURL) { [weak self] result in
            switch result {
            case .success(let taskData):
                XCTAssertEqual(taskData, data, "Incorrect data.")
            case .failure(let error):
                XCTFail("Error was not expected: \(error)")
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

}

