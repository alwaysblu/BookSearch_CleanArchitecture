//
//  SearchBooksUseCase.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

protocol SearchBooksUseCase {
    func search(request: SearchBooksUseCaseRequest,
                completion: @escaping (Result<BooksPage, Error>) -> Void) -> Cancellable?
}

struct SearchBooksUseCaseRequest {
    let query: String
    let page: Int
}

final class DefaultSearchBooksUseCase: SearchBooksUseCase {
    private let booksRepository: BooksRepository
    
    init(booksRepository: BooksRepository) {
        self.booksRepository = booksRepository
    }
    
    func search(request: SearchBooksUseCaseRequest,
                completion: @escaping (Result<BooksPage, Error>) -> Void) -> Cancellable? {
        return booksRepository.fetchBooks(query: request.query,
                                            page: request.page,
                                            completion: completion)
    }
}
