//
//  DefaultBooksRepository.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import Foundation

final class DefaultBooksRepository: BooksRepository {
    
    private let dataTransferService: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.dataTransferService = networkManager
    }
    
    func fetchBooks(query: String, startIndex: Int, maxResults: Int, completion: @escaping (Result<BookPage, Error>) -> Void) -> Cancellable? {
        guard let url = APIURL.getBookURL(query: BooksRequestDTO(query: query, startIndex: startIndex, maxResults: maxResults)) else { return nil }
        
        return dataTransferService.sendRequest(url: url, response: BooksResponseDTO.self) { result in
            switch result {
            case .success(let responseDTO) :
                completion(.success(responseDTO.toDomain()))
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
}
