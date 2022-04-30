//
//  DataForm.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/04/30.
//

import Foundation

public enum DataForm: String {
    static func converMultipart(_ boundary: String) -> String {
        return "multipart/form-data; boundary=\(boundary)"
    }
    case applicationJson = "application/json"
    case multipartForm
}
