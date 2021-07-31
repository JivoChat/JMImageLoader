//
//  ImageLoading.swift
//  JMImageLoader
//
//  Created by macbook on 31.07.2021.
//

import UIKit

protocol Cancellable {
    func cancel()
}

enum ImageLoadingError: Error {
    case failureResponse(statusCode: Int, error: Error?)
    case decodingError
    case unknown(Error?)
}

protocol ImageLoading {
    func loadImage(with url: URL, completion: @escaping (Result<UIImage, ImageLoadingError>) -> Void) -> Cancellable
}
