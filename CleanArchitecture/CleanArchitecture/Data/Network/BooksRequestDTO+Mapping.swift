//
//  BooksRequestDTO+Mapping.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import Foundation

struct BooksRequestDTO: Encodable {
    let query: String
    let startIndex: Int
    let maxResults: Int
}
