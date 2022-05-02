//
//  BooksSearchFlowCoordinator.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/01.
//

import UIKit

protocol BooksSearchFlowCoordinatorDependencies {
    func makeBooksSearchViewController() -> BooksSearchViewController
}

final class BooksSearchFlowCoordinator {
    private let dependencies: BooksSearchFlowCoordinatorDependencies
    private let navigationController: UINavigationController
    private weak var booksSearchViewController: BooksSearchViewController?
    
    init(navigationController: UINavigationController, dependencies: BooksSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let viewController = dependencies.makeBooksSearchViewController()
        navigationController.pushViewController(viewController, animated: true)
        booksSearchViewController = viewController
    }
}
