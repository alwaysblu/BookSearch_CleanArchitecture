//
//  BooksSceneDIContainer.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import UIKit

final class BooksSceneDIContainer {
    
    private let dependencies: Dependencies
    
    struct Dependencies {
        let dataTransferService: NetworkManager
    }
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension BooksSceneDIContainer {
    func makeSearchBooksUseCase() -> SearchBooksUseCase {
        DefaultSearchBooksUseCase(booksRepository: makeBooksRepository())
    }
    
    func makeBooksRepository() -> BooksRepository {
        return DefaultBooksRepository(networkManager: dependencies.dataTransferService)
    }
    
    func makeBooksSearchViewModel() -> BooksSearchViewModel {
        return DefaultBooksSearchViewModel(useCase: makeSearchBooksUseCase())
    }
    
    func makeBooksSearchViewController() -> BooksSearchViewController {
        return BooksSearchViewController.create(viewModel: makeBooksSearchViewModel())
    }
    
    func makeBooksSearchFlowCoordinator(navigationController: UINavigationController) -> BooksSearchFlowCoordinator {
        return BooksSearchFlowCoordinator(navigationController: navigationController,
                                          dependencies: self)
    }
}

extension BooksSceneDIContainer: BooksSearchFlowCoordinatorDependencies {}
