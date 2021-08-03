//
//  JMImageViewImageLoading.swift
//  JMImageLoader
//
//  Created by macbook on 03.08.2021.
//

import UIKit

public protocol JMImageViewImageLoading {
    func jmLoadImage(with url: URL) -> JMCancellable
    func jmLoadImage(with url: URL, usingStrategy loadingStrategy: JMImageLoading) -> JMCancellable
}
