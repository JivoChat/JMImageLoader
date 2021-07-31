//
//  ImageLoader.swift
//  JMImageLoader
//
//  Created by macbook on 31.07.2021.
//

import UIKit

class ImageLoader {
    
}

extension ImageLoader: ImageLoading {
    func loadImage(with url: URL, completion: @escaping (Result<UIImage, ImageLoadingError>) -> Void) -> Cancellable {
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let httpsResponse = response as? HTTPURLResponse else {
                return completion(.failure(.unknown(error)))
            }
            
            guard httpsResponse.statusCode == 200, error == nil else {
                return completion(.failure(.failureResponse(statusCode: httpsResponse.statusCode, error: error)))
            }
            
            guard
                let data = data,
                let image = UIImage(data: data)
            else {
                return completion(.failure(.decodingError))
            }
            
            completion(.success(image))
        }
        dataTask.resume()

        return dataTask
    }
}
