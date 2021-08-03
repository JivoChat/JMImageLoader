//
//  JMDefaultLoadingStrategyTask.swift
//  JMImageLoader
//
//  Created by macbook on 03.08.2021.
//

import Foundation

public struct JMDefaultLoadingStrategyTask {
    private let webImageLoader: WebImageLoading
    
    public init(webImageLoader: WebImageLoading) {
        self.webImageLoader = webImageLoader
    }
}

extension JMDefaultLoadingStrategyTask: JMCancellable {
    public func cancel() {
        webImageLoader.cancelCurrentLoading()
    }
}
