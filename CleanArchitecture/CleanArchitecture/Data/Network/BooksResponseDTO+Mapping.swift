//
//  BooksResponseDTO+Mapping.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/02.
//

import Foundation

// MARK: - Data Transfer Object

struct BooksResponseDTO: Codable {
    let totalItems: Int
    let items: [BookDTO]
}

extension BooksResponseDTO {
    struct BookDTO: Codable {
        let volumeInfo: VolumeInfo
    }
    
    struct VolumeInfo: Codable {
        let title: String?
        let authors: [String]?
        let publishedDate: String?
        let imageLinks: Thumbnail?
        let infoLink: String
    }
    
    struct Thumbnail: Codable {
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
                     thumbnail: volumeInfo.imageLinks?.thumbnail ?? "",
                     infoLink: volumeInfo.infoLink)
    }
}
