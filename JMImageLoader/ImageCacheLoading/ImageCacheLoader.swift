//
//  ImageCacheLoader.swift
//  JMImageLoader
//
//  Created by macbook on 02.08.2021.
//

import UIKit

public class ImageCacheLoader {
    private var nextLoader: JMImageLoadingNode?
    private let cache: ImageCaching
    
    required convenience public init(nextLoader: JMImageLoadingNode? = nil) {
        let defaultCache = ImageCache(config: .default)
        self.init(nextLoader: nextLoader, cache: defaultCache)
    }
    
    required public init(nextLoader: JMImageLoadingNode? = nil, cache: ImageCaching) {
        self.nextLoader = nextLoader
        self.cache = cache
    }
}

extension ImageCacheLoader: ImageCacheLoading {
    public func setNext(node: JMImageLoadingNode) {
        nextLoader = node
    }
    
    public func load(with url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let cachedImage = cache[url] else {
            nextLoader.flatMap { $0.load(with: url, completion: completion) } ?? completion(.failure(ImageCacheLoadingError.notFound)); return
        }
        
        completion(.success(cachedImage))
    }
}
