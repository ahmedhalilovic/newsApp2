//
//  NewResponse.swift
//  NewsAppTwo
//
//  Created by Ahmed Halilovic on 5. 9. 2024..
//

import Foundation

// MARK: - Welcome
struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Identifiable {
    let id = UUID()
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}

extension Article {
    
    static var dummyData: Article {
        .init(source: Source(id: "", name: "Android Central"),
              author: "jerry.hildenbrand@futurenet.com (Jerry Hildenbrand)",
              title: "Don't forget what else you need as you head back to school",
              description: "It's important to remember a few things to help mind your online privacy and security as you head off to school.",
              url: "https://www.adnroidcentral.com/apps-software/back-to-school-privacy-security-tips-2024",
              urlToImage: "https://cdn.mos.cms.futurecdn.net/4eyQMojyVhqQWNZZpXLMwL-1200-80.jpg",
              publishedAt: "2024-09-07T15:00:49Z",
              content: "It's that time of year, and millions of young men and women are heading off to school. For many going to college, this could be the first time they are responsible for themselves, while for others don't.")
    }
}
