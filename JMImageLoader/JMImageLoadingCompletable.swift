//
//  JMImageLoadingCompletable.swift
//  JMImageLoader
//
//  Created by macbook on 03.08.2021.
//

import UIKit

public protocol JMImageLoadingCompletable {
    func onSuccess(_ block: @escaping (UIImage) -> Void)
    func onFailure(_ block: @escaping (Error) -> Void)
}
