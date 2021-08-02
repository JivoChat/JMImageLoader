//
//  ImageCacheLoading.swift
//  JMImageLoader
//
//  Created by macbook on 02.08.2021.
//

import UIKit

public enum ImageCacheLoadingError: Error {
    case notFound
}

public protocol ImageCacheLoading: JMImageLoading {}
