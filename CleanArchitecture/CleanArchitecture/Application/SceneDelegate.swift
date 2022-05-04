//
//  SceneDelegate.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let navigationController = UINavigationController()
        let appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController, appDIContainer: AppDIContainer())
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        appFlowCoordinator.start()
    }
}

