//
//  JMImageViewImageLoading.swift
//  JMImageLoader
//
//  Created by macbook on 03.08.2021.
//

import UIKit

public protocol JMImageViewImageLoading {
    @discardableResult
    func jmLoadImage(with url: URL) -> JMImageLoadingCancellable
    @discardableResult
    func jmLoadImage(with url: URL, usingStrategy loadingStrategy: JMImageLoading) -> JMImageLoadingCancellable
}
