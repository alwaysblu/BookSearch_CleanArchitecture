//
//  DefaultBooksRepository.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

final class DefaultBooksRepository: BooksRepository {
    
    private let dataTransferService: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.dataTransferService = networkManager
    }
    
    func fetchBooks(query: String, page: Int, completion: @escaping (Result<BooksPage, Error>) -> Void) -> Cancellable? {
        guard let url = APIURL.getBookURL(query: BooksRequestDTO(query: query, page: page)) else { return nil }
        let request = RequestData(httpMethod: .get, dataForm: .applicationJson, accessToken: nil, request: BooksRequestDTO(query: query, page: page))
        
        return dataTransferService.sendRequest(url: url, request: request, response: BooksResponseDTO.self) { result in
            switch result {
            case .success(let responseDTO) :
                completion(.success(responseDTO.toDomain()))
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
}
