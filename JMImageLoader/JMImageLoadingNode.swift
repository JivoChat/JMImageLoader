//
//  JMImageLoading.swift
//  JMImageLoader
//
//  Created by macbook on 31.07.2021.
//

import UIKit

public protocol JMImageLoadingNode: JMImageLoading {
    init(nextLoader: JMImageLoadingNode?)
    
    func setNext(node: JMImageLoadingNode)
}
