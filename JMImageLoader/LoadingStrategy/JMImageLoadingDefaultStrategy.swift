//
//  JMImageLoadingDefaultStrategy.swift
//  JMImageLoader
//
//  Created by macbook on 02.08.2021.
//

import UIKit

class JMImageLoadingDefaultStrategy {
    private var cache: ImageCaching
    private let cacheLoader: ImageCacheLoader
    private let webLoader: WebImageLoader
    
    init(cache: ImageCaching, cacheLoader: ImageCacheLoader, webLoader: WebImageLoader) {
        self.cache = cache
        self.cacheLoader = cacheLoader
        self.webLoader = webLoader
        
        setUp()
    }
    
    private func setUp() {
        cacheLoader.setNext(node: webLoader)
    }
}

extension JMImageLoadingDefaultStrategy: JMImageLoading {
    func load(with url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        cacheLoader.load(with: url) { [weak self] result in
            switch result {
            case let .success(image):
                self?.cache[url] = image
                
            case let .failure(error):
                print(error)
                
            }
            
            completion(result)
        }
    }
}
