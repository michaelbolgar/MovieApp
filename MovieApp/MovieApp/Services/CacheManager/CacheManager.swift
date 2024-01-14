//
//  CacheManager.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 10.01.2024.
//

import UIKit

final class ImageCache {
    
    // MARK: - Static Properties
    static let shared = ImageCache()
    
    // MARK: - Private Properties
    private var cache = NSCache<NSString, UIImage>()
    
    // MARK: - Private init
    private init() {}

    // MARK: - Public Methods
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
