//
//  APIDataNetworkConfiguration.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

struct APIConfiguration {
    let baseURL: String
    let queryParameters: [String: String]
}

enum APIURL {
    private static let apiConfig = APIConfiguration(baseURL: "http://api.themoviedb.org", queryParameters:  ["language": "en", "api_key": "2696829a81b1b5827d515ff121700838"])
    private static let imageConfig = APIConfiguration(baseURL: "http://image.tmdb.org", queryParameters: [:])
    
    static func getMovieURL(query: MoviesRequestDTO) -> URL? {
        var path = "?page=\(query.page)&query=\(query.query)"
        apiConfig.queryParameters.forEach {
            path += "&\($0.key)=\($0.value)"
        }
        return URL(string: apiConfig.baseURL + "/" + path)
    }
}
