//
//  NetworkLoader.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import Foundation

protocol NetworkLoader {
    init(session: URLSession)
    
    func loadData(with url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
    
    func loadData(with request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}

struct DefaultNetworkLoader: NetworkLoader {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    private func checkValidation(data: Data?, response: URLResponse?, error: Error?) -> Result<Data, Error> {
        if let error = error {
            return .failure(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure(DataError.invalidResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            return .failure(DataError.statusCode)
        }
        
        guard let data = data else {
            return .failure(DataError.invalidData)
        }
        
        return .success(data)
    }
    
    func loadData(with url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
        let dataTask = session.dataTask(with: url) { data, response, error in
            let result = self.checkValidation(data: data, response: response, error: error)
            
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        dataTask.resume()
        
        return dataTask
    }
    
    func loadData(with request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
        let dataTask = session.dataTask(with: request) { data, response, error in
            let result = self.checkValidation(data: data, response: response, error: error)
            
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        dataTask.resume()
        
        return dataTask
    }
}
