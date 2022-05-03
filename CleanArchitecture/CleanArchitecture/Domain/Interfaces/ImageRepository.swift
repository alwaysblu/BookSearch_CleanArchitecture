//
//  ImageRepository.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import UIKit

protocol ImageRepository {
    func downloadImage(url: String,
                    completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable?
}
