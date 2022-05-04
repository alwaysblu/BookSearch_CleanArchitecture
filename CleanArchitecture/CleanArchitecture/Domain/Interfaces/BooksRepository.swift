//
//  BooksRepository.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import Foundation

protocol BooksRepository {
    func fetchBooks(query: String,
                    startIndex: Int,
                    maxResults: Int,
                    completion: @escaping (Result<BookPage, Error>) -> Void) -> Cancellable?
}
