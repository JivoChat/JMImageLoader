//
//  Abstract.swift
//  JMImageLoader
//
//  Created by macbook on 31.07.2021.
//

import UIKit

public protocol JMImageLoading {
    init(nextLoader: JMImageLoading?)

    @discardableResult
    func load(with url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> Cancellable
}

public enum JMImageLoadingStrategy {
    case `default`
    case custom(JMImageLoading)
}

public protocol Cancellable {
    func cancel()
}

func test() {
    let a1: JMImageLoading = WebImageLoader()
    let a2: JMImageLoading = WebImageLoader(nextLoader: a1)
}
