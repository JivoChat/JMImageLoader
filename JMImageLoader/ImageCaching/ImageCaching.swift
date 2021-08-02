//
//  ImageCaching.swift
//  JMImageLoader
//
//  Created by macbook on 31.07.2021.
//

import UIKit

public protocol ImageCaching {
    subscript(_ url: URL) -> UIImage? { get set }
    
    func removeImage(by url: URL)
    func removeAllImages()
}
