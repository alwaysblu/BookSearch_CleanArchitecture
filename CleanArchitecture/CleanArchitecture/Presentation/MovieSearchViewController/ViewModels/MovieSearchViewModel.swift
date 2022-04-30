//
//  MovieSearchViewModel.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

final class MovieSearchViewModel {
    private var currentPage: Int = 0
    private var totalPage: Int = 1
    private var nextPage: Int { currentPage < totalPage ? currentPage + 1 : currentPage }
    private let useCase: SearchMoviesUseCase
    var items: [MovieSearchItemViewModel] = []
    private var pages: [MoviesPage] = []
    
    
    init(useCase: SearchMoviesUseCase) {
        self.useCase = useCase
    }
    
}

extension MovieSearchViewModel {
    func searchMovie(query: String) {
        useCase.search(request: .init(query: query, page: nextPage)) { [weak self] result in
            switch result {
            case .success(let response) :
                self?.appendPage(response)
            case .failure(let error) :
                "\(error)".log()
            }
        }
    }
    
    private func appendPage(_ moviesPage: MoviesPage) {
        currentPage = moviesPage.page
        totalPage = moviesPage.totalPages

        pages = pages
            .filter { $0.page != moviesPage.page }
            + [moviesPage]

        items = pages.flatMap{$0.movies}.map(MovieSearchItemViewModel.init)
    }
    
    private func resetPages() {
        currentPage = 0
        totalPage = 1
        pages.removeAll()
        items.removeAll()
    }
}
