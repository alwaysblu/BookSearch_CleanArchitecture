//
//  Cancellable.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import Foundation

protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable { }
