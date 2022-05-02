//
//  booksSearchItemViewModel.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

struct BooksSearchItemViewModel {
    let title: String
    let overView: String
    let releaseDate: String
    let posterImageUrl: String?
}

extension BooksSearchItemViewModel {
    init(book: Book) {
        self.title = book.title ?? ""
        overView = book.description ?? ""
        posterImageUrl = book.thumbNailUrl
        if let releaseDate = book.date {
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
