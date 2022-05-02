//
//  BooksResponseDTO+Mapping.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

// MARK: - Data Transfer Object

struct BooksResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case books = "results"
    }
    let page: Int
    let totalPages: Int
    let books: [BookDTO]
}

extension BooksResponseDTO {
    struct BookDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case title
            case posterPath = "poster_path"
            case overview
            case releaseDate = "release_date"
        }
        let title: String?
        let posterPath: String?
        let overview: String?
        let releaseDate: String?
    }
}

// MARK: - Mappings to Domain

extension BooksResponseDTO {
    func toDomain() -> BooksPage {
        return .init(page: page,
                     totalPages: totalPages,
                     books: books.map { $0.toDomain() })
    }
}

extension BooksResponseDTO.BookDTO {
    func toDomain() -> Book {
        return .init(thumbNailUrl: posterPath,
                     title: title,
                     date: dateFormatter.date(from: releaseDate ?? ""),
                     description: overview)
    }
}

// MARK: - Private

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()
