//
//  WebImageLoading.swift
//  JMImageLoader
//
//  Created by macbook on 31.07.2021.
//

import UIKit

enum WebImageLoadingError: Error {
    case failureResponse(statusCode: Int, error: Error?)
    case decodingError
    case unknown(Error?)
}

protocol WebImageLoading: JMImageLoading {}
