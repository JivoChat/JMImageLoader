//
//  ImageCacheLoader.swift
//  JMImageLoader
//
//  Created by macbook on 02.08.2021.
//

import UIKit

class ImageCacheLoader {
    private let nextLoader: JMImageLoading?
    private let cache: ImageCaching
    
    required convenience init(nextLoader: JMImageLoading? = nil) {
        let defaultCache = ImageCache(config: .default)
        self.init(nextLoader: nextLoader, cache: defaultCache)
    }
    
    required init(nextLoader: JMImageLoading? = nil, cache: ImageCaching) {
        self.nextLoader = nextLoader
        self.cache = cache
    }
}

extension ImageCacheLoader: ImageCacheLoading {
    func load(with url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let cachedImage = cache[url] else {
            nextLoader.flatMap { $0.load(with: url, completion: completion) } ?? completion(.failure(ImageCacheLoadingError.notFound)); return
        }
        
        completion(.success(cachedImage))
    }
}
