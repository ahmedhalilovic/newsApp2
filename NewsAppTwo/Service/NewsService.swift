//
//  NewsService.swift
//  NewsAppTwo
//
//  Created by Ahmed Halilovic on 7. 9. 2024..
//

import Foundation
import Combine

protocol NewsService {
    // Using Any Publisher because we don't want to expose details to different modules
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError>
}

struct NewsServiceImpl: NewsService {
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError> {
        
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<NewsResponse, APIError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    
                    return Just(data)
                        .decode(type: NewsResponse.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                    
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
                
            }
            .eraseToAnyPublisher()
    }
}
