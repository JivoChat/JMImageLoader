//
//  JMImageLoadingDefaultStrategy.swift
//  JMImageLoader
//
//  Created by macbook on 02.08.2021.
//

import UIKit

class JMImageLoadingDefaultStrategy {
    private let cache: ImageCaching
    private let cacheLoader: ImageCacheLoader
    private let webLoader: WebImageLoader
    
    init(cache: ImageCaching, cacheLoader: ImageCacheLoader, webLoader: WebImageLoader) {
        self.cache = cache
        self.cacheLoader = cacheLoader
        self.webLoader = webLoader
    }
}

extension JMImageLoadingDefaultStrategy: JMImageLoading {
    func load(with url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
    }
}
