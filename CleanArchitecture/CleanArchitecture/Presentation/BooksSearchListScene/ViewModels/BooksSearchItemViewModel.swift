//
//  booksSearchItemViewModel.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

struct BooksSearchItemViewModel {
    let title: String?
    let authors: [String]?
    let publishedDate: String?
    let smallThumbnail: String
    let thumbnail: String
}

extension BooksSearchItemViewModel {
    init(book: Book) {
        title = book.title
        authors = book.authors
        publishedDate = book.publishedDate
        smallThumbnail = book.smallThumbnail
        thumbnail = book.thumbnail
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
