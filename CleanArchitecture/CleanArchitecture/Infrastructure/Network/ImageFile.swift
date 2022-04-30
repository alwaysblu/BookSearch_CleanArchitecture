//
//  ImageFile.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//
import UIKit

struct ImageFile {
    let data: Data
    let key: String
    let fileName: String
    let mimeType: String
    
    init?(data: Data,
          forKey key: String,
          fileName: String,
          mimeType: String = "image/jpeg",
          fileType: String = ".jpg") {
        
        self.data = data
        self.key = key
        self.fileName = fileName + fileType
        self.mimeType = mimeType
    }
}
