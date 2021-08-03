//
//  ImageLoadingStrategyFactory.swift
//  JMImageLoader
//
//  Created by macbook on 03.08.2021.
//

import Foundation

enum ImageLoadingStrategyFactory {
    case `default`(withImageCacheMemoryLimit: Int)
    
    static func defaultShared(withImageCacheMemoryLimit imageCacheMemoryLimit: Int) -> JMImageLoading {
        return defaultShared.flatMap { $0 }
            ?? buildDefault(withImageCacheMemoryLimit: imageCacheMemoryLimit)
    }
}

extension ImageLoadingStrategyFactory {
    private static var defaultShared: JMImageLoading? = nil
    
    private static func buildDefault(withImageCacheMemoryLimit imageCacheMemoryLimit: Int) -> JMImageLoadingDefaultStrategy {
        let imageCacheConfig = ImageCache.Config(memoryLimit: imageCacheMemoryLimit)
        let imageCache = ImageCache(config: imageCacheConfig)
        
        let webImageLoader = WebImageLoader()
        let imageCacheLoader = ImageCacheLoader(nextLoader: webImageLoader, cache: imageCache)
        
        let logger = Logger(loggingLevel: .full)
        
        let imageLoadingDefaultStrategy = JMImageLoadingDefaultStrategy(cache: imageCache, cacheLoader: imageCacheLoader, webLoader: webImageLoader, logger: logger)
        defaultShared = imageLoadingDefaultStrategy
        
        return imageLoadingDefaultStrategy
    }
}

extension ImageLoadingStrategyFactory: Building {
    func build() -> JMImageLoading {
        switch self {
        case let .default(imageCacheMemoryLimit):
            return ImageLoadingStrategyFactory.buildDefault(withImageCacheMemoryLimit: imageCacheMemoryLimit)
        }
    }
}
