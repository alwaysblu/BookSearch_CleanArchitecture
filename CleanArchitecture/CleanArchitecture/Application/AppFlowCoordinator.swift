//
//  AppFlowCordinator.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import UIKit

final class AppFlowCoordinator {
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
}

extension AppFlowCoordinator {
    func start() {
        let booksSceneDIContainer = appDIContainer.makeBooksSceneDIContainer()
        let flow = booksSceneDIContainer.makeBooksSearchFlowCoordinator(navigationController: navigationController)
        
        flow.start()
    }
}
