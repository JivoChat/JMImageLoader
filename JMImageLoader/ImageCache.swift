//
//  ImageCache.swift
//  JMImageLoader
//
//  Created by macbook on 31.07.2021.
//

import UIKit

class ImageCache {
    // MARK: Preinitialized private properties
    private let internalCache = NSCache<NSString, UIImage>()
    
    // MARK: Private properties initializing via init
    private let config: Config
    
    // MARK: Init
    init(config: Config = .default) {
        self.config = config
        
        setUp()
    }
    
    // MARK: Private methods
    // Setting up
    private func setUp() {
        internalCache.totalCostLimit = config.memoryLimit
    }
    
    // Other
    private func insertImage(_ image: UIImage?, with url: URL) {
        guard let image = image else { return removeImage(by: url) }
        internalCache.setObject(image, forKey: NSString(string: url.absoluteString))
    }
    
    private func image(for url: URL) -> UIImage? {
        guard let cachedImage = internalCache.object(forKey: NSString(string: url.absoluteString)) else {
            return nil
        }
        
        return cachedImage
    }
}

// MARK: ImageCaching conformance for ImageCache

extension ImageCache: ImageCaching {
    subscript(url: URL) -> UIImage? {
        get {
            return image(for: url)
        }
        set {
            insertImage(newValue, with: url)
        }
    }
    
    func removeImage(by url: URL) {
        internalCache.removeObject(forKey: NSString(string: url.absoluteString))
    }
    
    func removeAllImages() {
        internalCache.removeAllObjects()
    }
}

// MARK: ImageCache.Config

extension ImageCache {
    struct Config {
        // MARK: Static properties
        private static let DEFAULT_MEMORY_LIMIT = 1024 * 1024 * 50
        
        // MARK: Public properties initializing via init
        let memoryLimit: Int
        
        // MARK: Static properties
        static let `default` = Config(memoryLimit: DEFAULT_MEMORY_LIMIT)
    }
}
