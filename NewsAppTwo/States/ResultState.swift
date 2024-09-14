//
//  ResultState.swift
//  NewsAppTwo
//
//  Created by Ahmed Halilovic on 8. 9. 2024..
//

import Foundation

// Enumeration that represents the possible states of an asynchronous operation
enum ResultState {
    case loadnig
    case success(content: [Article])
    case failed(error: Error)
}
