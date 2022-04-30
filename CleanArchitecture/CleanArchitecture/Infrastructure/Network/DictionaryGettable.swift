//
//  DictionaryGettable.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

public protocol DictionaryGettable {
    var dictionary: [String: Any?] { get }
}
