//
//  JMImageViewImageLoading.swift
//  JMImageLoader
//
//  Created by macbook on 03.08.2021.
//

import UIKit

protocol JMImageViewImageLoading {
    func jmLoadImage(with url: URL, usingStrategy loadingStrategy: JMImageLoading)
}