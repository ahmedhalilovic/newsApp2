//
//  NewsEndpoint.swift
//  NewsAppTwo
//
//  Created by Ahmed Halilovic on 5. 9. 2024..
//

import Foundation

protocol APIBuilder {
    var baseURL: URL { get }
    var APIKey: String { get }
    var urlRequest: URLRequest { get }
    
}

enum NewsAPI {
    case getNews
}

/*
 URL: https://newsapi.org/v2/everything?q=apple&from=2024-09-03&to=2024-09-03&sortBy=popularity&apiKey=547bdc163baa4c888423e9e3d62f0314
 */

extension NewsAPI: APIBuilder {
    var baseURL: URL {
        switch self {
        case .getNews:
            return  URL(string: "https://newsapi.org/v2/everything")!
        }
    }
    
    var APIKey: String {
        
        return "547bdc163baa4c888423e9e3d62f0314"
        
    }
    
    var urlRequest: URLRequest {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        
        // Define the query parameters
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: "tesla"),
            URLQueryItem(name: "from", value: "2024-08-14"),
            URLQueryItem(name: "sortBy", value: "publishedAt"),
            URLQueryItem(name: "apiKey", value: APIKey)
        ]
        
        guard let fullURL = urlComponents.url else {
            fatalError("Invalid URL")
        }
        
        print("Full URL: \(fullURL.absoluteString)")
        
        return URLRequest(url: fullURL)
    }
    
}

/*
 
 // Simpler way to make url
 
 extension NewsAPI: APIBuilder {
     var baseURL: String {
         switch self {
         case .getNews:
             return  "https://newsapi.org/v2/everything?q=apple&from=2024-09-03&to=2024-09-03&sortBy=popularity&apiKey="
         }
     }

     var APIKey: String {

         return "547bdc163baa4c888423e9e3d62f0314"

     }

     var urlRequest: URLRequest {

         let fullURLString = baseURL + APIKey

         guard let fullURL = URL(string: fullURLString) else {
             fatalError("Invalid URL")
         }

         print("Full URL: \(fullURL.absoluteString)")

         return URLRequest(url: fullURL)
     }

 }
 */
