//
//  MoviesRepository.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

protocol MoviesRepository {
    func fetchMovies(query: String,
                     page: Int,
                     completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
}
