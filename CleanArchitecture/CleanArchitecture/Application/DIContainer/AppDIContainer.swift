//
//  AppDIContainer.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation


final class AppDIContainer {
    
    let dataTransferService: NetworkManager = {
        let networkLoader = DefaultNetworkLoader()
        let networkManager = DefaultNetworkManager(networkLoader: networkLoader)
        
        return networkManager
    }()
    
    func makeBooksSceneDIContainer() -> BooksSceneDIContainer {
        let dependencies = BooksSceneDIContainer.Dependencies(dataTransferService: dataTransferService)
        
        return BooksSceneDIContainer(dependencies: dependencies)
    }
}
