//
//  BooksResponseDTO+Mapping.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

// MARK: - Data Transfer Object

struct BooksResponseDTO: Decodable {
    let totalItems: Int
    let items: [BookDTO]
}

extension BooksResponseDTO {
    struct BookDTO: Decodable {
        let volumeInfo: VolumeInfo
    }
    
    struct VolumeInfo: Decodable {
        let title: String?
        let authors: [String]?
        let publishedDate: String?
        let imageLinks: Thumbnail?
        let infoLink: String
    }
    
    struct Thumbnail: Decodable {
        let smallThumbnail: String
        let thumbnail: String
    }
}

// MARK: - Mappings to Domain

extension BooksResponseDTO {
    func toDomain() -> BookPage {
        return .init(totalItems: totalItems,
                     books: items.map { $0.toDomain() })
    }
}

extension BooksResponseDTO.BookDTO {
    func toDomain() -> Book {
        return .init(title: volumeInfo.title,
                     authors: volumeInfo.authors,
                     publishedDate: volumeInfo.publishedDate,
                     smallThumbnail: volumeInfo.imageLinks?.smallThumbnail ?? "",
                     thumbnail: volumeInfo.imageLinks?.thumbnail ?? "",
                     infoLink: volumeInfo.infoLink)
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
