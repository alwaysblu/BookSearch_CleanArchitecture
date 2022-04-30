//
//  AppFlowCordinator.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/01.
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
        let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
        let flow = moviesSceneDIContainer.makeMovieSearchFlowCoordinator(navigationController: navigationController)
        
        flow.start()
    }
}
