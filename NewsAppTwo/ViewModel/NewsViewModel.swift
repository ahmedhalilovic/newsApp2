//
//  NewsViewModel.swift
//  NewsAppTwo
//
//  Created by Ahmed Halilovic on 8. 9. 2024..
//

import Foundation
import Combine

protocol NewsViewModel {
    func getArticles()
}

class NewsViewModelImpl: ObservableObject, NewsViewModel {
    
    private let service: NewsService
    
    private(set) var articles = [Article]() // "(set)" is used to protect variable within the class. Variable can only be set within the class or it's extensions
    
    private var cancellebles = Set<AnyCancellable>() // Need to have colletion of cancellebles, because when we call service we need to keep it in memory or it will be dispossed and API request will never be triggered
    
    @Published private(set) var state: ResultState = .loadnig
    
    init(service: NewsService) {
        self.service = service
    }
    
    func getArticles() {
        
        self.state = .loadnig
        
        let cancellable = service
            .request(from: .getNews)
            .sink { res in
                switch res {
                case .finished:
                    // Send back the articles
                    self.state = .success(content: self.articles)
                    break
                case .failure(let error):
                    // Send back the error
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: { response in
                self.articles = response.articles
            }
        self.cancellebles.insert(cancellable)
    }
}
