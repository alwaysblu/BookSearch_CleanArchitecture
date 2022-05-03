//
//  ImageCache.swift
//  CleanArchitecture
//
//  Created by 최정민 on 2022/05/03.
//

import UIKit

protocol ImageCache {
    var images: NSCache<NSString, UIImage> { get }
}

final class DefaultImageCache: ImageCache {
    let images = NSCache<NSString, UIImage>()
}
