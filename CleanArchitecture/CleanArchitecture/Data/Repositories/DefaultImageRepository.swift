//
//  DefaultImageRepository.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import UIKit
import RxSwift

final class DefaultImageRepository: ImageRepository {
    
    private let dataTransferService: NetworkManager
    private let imageCache: ImageCache
    private var disposeBag = DisposeBag()
    
    init(networkManager: NetworkManager, imageCache: ImageCache) {
        self.dataTransferService = networkManager
        self.imageCache = imageCache
    }
    
    func downloadImage(urlString: String, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable? {
        guard let url = URL(string: urlString) else { return nil }
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
        
        let cacheObservable = checkCache(url: urlString)
        cacheObservable.subscribe { image in
            guard let cachedImage = image.element,
                  cachedImage != nil else {
                return
            }
            completion(.success(cachedImage))
            dataTask?.cancel()
        }.disposed(by: disposeBag)
        
        return dataTask
    }
    
    private func checkCache(url: String) -> Observable<UIImage?> {
        return Observable.create { [weak self] observer in
            guard let image = self?.imageCache.images.object(forKey: url as NSString) else {
                observer.onNext(nil)
                return Disposables.create()
            }
            observer.onNext(image)
            return Disposables.create()
        }
    }
    
}
