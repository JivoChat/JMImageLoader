//
//  ImageCacheLoader.swift
//  JMImageLoader
//
//  Created by macbook on 02.08.2021.
//

import UIKit

public class ImageCacheLoader {
    private let nextLoader: JMImageLoading?
    private let cache: ImageCaching
    
    required convenience public init(nextLoader: JMImageLoading? = nil) {
        let defaultCache = ImageCache(config: .default)
        self.init(nextLoader: nextLoader, cache: defaultCache)
    }
    
    required public init(nextLoader: JMImageLoading? = nil, cache: ImageCaching) {
        self.nextLoader = nextLoader
        self.cache = cache
    }
}

extension ImageCacheLoader: ImageCacheLoading {
    public func load(with url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let cachedImage = cache[url] else {
            nextLoader.flatMap { $0.load(with: url, completion: completion) } ?? completion(.failure(ImageCacheLoadingError.notFound)); return
        }
        
        completion(.success(cachedImage))
    }
}
