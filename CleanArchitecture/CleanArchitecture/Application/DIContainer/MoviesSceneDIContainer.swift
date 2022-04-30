//
//  MovieSceneDIContainer.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import UIKit

final class MoviesSceneDIContainer {
    
    private let dependencies: Dependencies
    
    struct Dependencies {
        let dataTransferService: NetworkManager
    }
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension MoviesSceneDIContainer {
    func makeSearchMoviesUseCase() -> SearchMoviesUseCase {
        DefaultSearchMoviesUseCase(moviesRepository: makeMoviesRepository())
    }
    
    func makeMoviesRepository() -> MoviesRepository {
        return DefaultMoviesRepository(networkManager: dependencies.dataTransferService)
    }
    
    func makeMovieSearchViewModel() -> MovieSearchViewModel {
        return DefaultMovieSearchViewModel(useCase: makeSearchMoviesUseCase())
    }
    
    func makeMovieSearchViewController() -> MovieSearchViewController {
        return MovieSearchViewController.create(viewModel: makeMovieSearchViewModel())
    }
    
    func makeMovieSearchFlowCoordinator(navigationController: UINavigationController) -> MovieSearchFlowCoordinator {
        return MovieSearchFlowCoordinator(navigationController: navigationController,
                                          dependencies: self)
    }
}

extension MoviesSceneDIContainer: MovieSearchFlowCoordinatorDependencies {}
