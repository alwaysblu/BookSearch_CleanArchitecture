//
//  SearchBooksUseCase.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import Foundation

protocol SearchBooksUseCase {
    func search(request: SearchBooksUseCaseRequest,
                completion: @escaping (Result<BookPage, Error>) -> Void) -> Cancellable?
}

struct SearchBooksUseCaseRequest {
    let query: String
    let startIndex: Int
    let maxResult: Int
}

final class DefaultSearchBooksUseCase: SearchBooksUseCase {
    private let booksRepository: BooksRepository
    
    init(booksRepository: BooksRepository) {
        self.booksRepository = booksRepository
    }
    
    func search(request: SearchBooksUseCaseRequest,
                completion: @escaping (Result<BookPage, Error>) -> Void) -> Cancellable? {
        return booksRepository.fetchBooks(query: request.query,
                                          startIndex: request.startIndex,
                                          maxResults: request.maxResult,
                                          completion: completion)
    }
}
