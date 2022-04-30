//
//  SearchMoviesUseCase.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

protocol SearchMoviesUseCase {
    func search(request: SearchMoviesUseCaseRequest,
                completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
}

struct SearchMoviesUseCaseRequest {
    let query: String
    let page: Int
}

final class DefaultSearchMoviesUseCase: SearchMoviesUseCase {
    private let moviesRepository: MoviesRepository
    
    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    func search(request: SearchMoviesUseCaseRequest,
                completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable? {
        return moviesRepository.fetchMovies(query: request.query,
                                            page: request.page,
                                            completion: completion)
    }
}
