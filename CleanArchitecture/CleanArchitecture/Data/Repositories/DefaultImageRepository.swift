//
//  DefaultImageRepository.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import UIKit

final class DefaultImageRepository: ImageRepository {
    
    private let dataTransferService: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.dataTransferService = networkManager
    }
    
    func downloadImage(url: String, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = dataTransferService.sendRequest(url: url) { result in
            switch result {
            case .success(let image) :
                completion(.success(image))
            case .failure(let error) :
                "\(error.localizedDescription)".log()
            }
        }
        
        return dataTask
    }
}
