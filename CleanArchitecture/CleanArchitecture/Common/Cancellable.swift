//
//  Cancellable.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable { }
