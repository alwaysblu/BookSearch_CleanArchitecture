//
//  AppConfigurations.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

enum AppConfigurations {
    static let apiKey = "2696829a81b1b5827d515ff121700838"
    static let apiBaseUrl = "http://api.themoviedb.org"
    static let imageBaseUrl = "http://image.tmdb.org"
}

struct APIConfiguration {
    let baseURL: String
    let queryParameters: [String: String]
}

enum APIURL {
    private static let apiConfig = APIConfiguration(baseURL: AppConfigurations.apiBaseUrl,
                                                    queryParameters:  ["language": "en",
                                                                       "api_key": AppConfigurations.apiKey])
    private static let imageConfig = APIConfiguration(baseURL: AppConfigurations.imageBaseUrl,
                                                      queryParameters: [:])
    
    static func getBookURL(query: BooksRequestDTO) -> URL? {
        var path = "?page=\(query.page)&query=\(query.query)"
        apiConfig.queryParameters.forEach {
            path += "&\($0.key)=\($0.value)"
        }
        return URL(string: apiConfig.baseURL + "/" + path)
    }
}
