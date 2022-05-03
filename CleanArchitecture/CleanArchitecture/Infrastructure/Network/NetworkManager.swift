//
//  NetworkManager.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import UIKit

protocol NetworkManager {
    init(networkLoader: NetworkLoader)
    // MARK: Interface functions
    
    func sendRequest<Response>(url: URL,
                               response: Response.Type,
                               completion: @escaping (Result<Response, Error>) -> Void) -> Cancellable? where Response: Decodable
    
    func sendRequest(url: URL,
                               completion: @escaping (Result<UIImage, Error>) -> Void) -> Cancellable?
}

final public class DefaultNetworkManager: NetworkManager {
    private var networkLoader: NetworkLoader
    
    init(networkLoader: NetworkLoader) {
        self.networkLoader = networkLoader
    }
    
    // MARK: Interface functions
    
    func sendRequest<Response>(url: URL,
                               response: Response.Type,
                               completion: @escaping (Result<Response, Error>) -> Void) -> Cancellable? where Response: Decodable {
        
        return networkLoader.loadData(with: url) { [weak self] result in
            self?.handleResponseData(result: result, completion: completion)
        }
    }
    
    func sendRequest(url: URL,
                               completion: @escaping (Result<UIImage, Error>) -> Void) -> Cancellable? {
        
        return networkLoader.loadData(with: url) { result in
            switch result {
            case .success(let data) :
                guard let image = UIImage(data: data)
                    else {
                        return
                }
                completion(.success(image))
            case .failure(let error) :
                "\(error.localizedDescription)".log()
            }
        }
    }
    

    // MARK: Private functions
    
    
    private func handleResponseData<Response>(result: Result<Data, Error>,
                                              completion: @escaping (Result<Response, Error>) -> Void) where Response: Decodable {
        switch result {
        case .success(let data):
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
