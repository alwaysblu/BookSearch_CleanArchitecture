//
//  AppDIContainer.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import Foundation

final class AppDIContainer {
    let dataTransferService: NetworkManager = {
        let networkLoader = DefaultNetworkLoader()
        let networkManager = DefaultNetworkManager(networkLoader: networkLoader)
        
        return networkManager
    }()
    let imageCache: ImageCache = {
        return DefaultImageCache()
    }()
    
    func makeBooksSceneDIContainer() -> BooksSceneDIContainer {
        let dependencies = BooksSceneDIContainer.Dependencies(dataTransferService: dataTransferService, imageCache: imageCache)
        
        return BooksSceneDIContainer(dependencies: dependencies)
    }
}
