//
//  MovieRequestDTO+Mapping.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

struct MoviesRequestDTO: Encodable {
    let query: String
    let page: Int
}
