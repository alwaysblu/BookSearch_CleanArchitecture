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
        request.httpMethod = "GET"

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    return
            }
            completion(.success(image))
        }
        
        dataTask.resume()
        
        return dataTask
    }
}
