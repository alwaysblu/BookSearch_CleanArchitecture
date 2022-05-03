//
//  BooksSearchFlowCoordinator.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import UIKit
import SafariServices

protocol BooksSearchFlowCoordinatorDependencies {
    func makeBooksSearchViewController(actions: BooksSearchViewModelActions) -> BooksSearchViewController
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
        let actions = BooksSearchViewModelActions(showBookDetails: showDetailInformation)
        let viewController = dependencies.makeBooksSearchViewController(actions: actions)
        navigationController.pushViewController(viewController, animated: true)
        booksSearchViewController = viewController
    }
    
    func showDetailInformation(book: Book) {
        guard let url = URL(string: book.infoLink) else { return }
        let detailViewController: SFSafariViewController = SFSafariViewController(url: url)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
