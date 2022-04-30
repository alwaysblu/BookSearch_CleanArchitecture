//
//  MovieSearchFlowCoordinator.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/01.
//

import UIKit

protocol MovieSearchFlowCoordinatorDependencies {
    func makeMovieSearchViewController() -> MovieSearchViewController
}

final class MovieSearchFlowCoordinator {
    private let dependencies: MovieSearchFlowCoordinatorDependencies
    private let navigationController: UINavigationController
    private weak var movieSearchViewController: MovieSearchViewController?
    
    init(navigationController: UINavigationController, dependencies: MovieSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let viewController = dependencies.makeMovieSearchViewController()
        navigationController.pushViewController(viewController, animated: true)
        movieSearchViewController = viewController
    }
}
