//
//  MovieSearchItemViewModel.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

struct MovieSearchItemViewModel {
    let title: String
    let overView: String
    let releaseDate: String
    let posterImageUrl: String?
}

extension MovieSearchItemViewModel {
    init(movie: Movie) {
        self.title = movie.title ?? ""
        overView = movie.description ?? ""
        posterImageUrl = movie.thumbNailUrl
        if let releaseDate = movie.date {
            self.releaseDate = "Release Date: " + dateFormatter.string(from: releaseDate)
        } else {
            releaseDate = "To be announced"
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
