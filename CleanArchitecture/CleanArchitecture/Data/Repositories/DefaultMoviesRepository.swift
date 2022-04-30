//
//  DefaultMoviesRepository.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

final class DefaultMoviesRepository: MoviesRepository {
    
    private let dataTransferService: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.dataTransferService = networkManager
    }
    
    func fetchMovies(query: String, page: Int, completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable? {
        guard let url = APIURL.getMovieURL(query: MoviesRequestDTO(query: query, page: page)) else { return nil }
        let request = RequestData(httpMethod: .get, dataForm: .applicationJson, accessToken: nil, request: MoviesRequestDTO(query: query, page: page))
        
        return dataTransferService.sendRequest(url: url, request: request, response: MoviesResponseDTO.self) { result in
            switch result {
            case .success(let responseDTO) :
                completion(.success(responseDTO.toDomain()))
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
}
