//
//  WebImageLoader.swift
//  JMImageLoader
//
//  Created by macbook on 31.07.2021.
//

import UIKit

public class WebImageLoader {
    private var nextLoader: JMImageLoadingNode?
    
    private var currentImageLoadingDataTask: URLSessionDataTask? = nil
    
    required public init(nextLoader: JMImageLoadingNode? = nil) {
        self.nextLoader = nextLoader
    }
    
    func cancelCurrentLoading() {
        currentImageLoadingDataTask?.cancel()
    }
    
    private func handleResult(
        _ result: Result<UIImage, Error>,
        ofRequestWithUrl url: URL,
        forCompletionHandler completionHandler: @escaping (Result<UIImage, Error>) -> Void
    ) {
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success:
                completionHandler(result)
                
            case .failure:
                self?.nextLoader.flatMap { $0.load(with: url, completion: completionHandler) } ?? completionHandler(result)
            }
        }
    }
}

extension WebImageLoader: WebImageLoading {
    public func setNext(node: JMImageLoadingNode) {
        nextLoader = node
    }
    
    public func load(with url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let httpsResponse = response as? HTTPURLResponse else {
                self?.handleResult(.failure(WebImageLoadingError.unknown(error)), ofRequestWithUrl: url, forCompletionHandler: completion); return
            }
            
            guard httpsResponse.statusCode == 200, error == nil else {
                self?.handleResult(.failure(WebImageLoadingError.failureResponse(statusCode: httpsResponse.statusCode, error: error)), ofRequestWithUrl: url, forCompletionHandler: completion); return
            }
            
            guard
                let data = data,
                let image = UIImage(data: data)
            else {
                return completion(.failure(WebImageLoadingError.decodingError))
            }
            
            self?.handleResult(.success(image), ofRequestWithUrl: url, forCompletionHandler: completion)
        }
        currentImageLoadingDataTask = dataTask
        dataTask.resume()
    }
}
