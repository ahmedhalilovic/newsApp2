//
//  HomeView.swift
//  NewsAppTwo
//
//  Created by Ahmed Halilovic on 5. 9. 2024..
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.openURL) var openUrl
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    
    var body: some View {
        Group {
            
            switch viewModel.state {
            case .loadnig:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, handler: viewModel.getArticles)
            case .success(let articles):
                NavigationView {
                    List(articles) { item in
                        ArticleView(article: item)
                            .onTapGesture {
                                load(url: item.url)
                            }
                    }
                    .navigationTitle(Text("News"))
                }
            }
        }
        .onAppear(perform: viewModel.getArticles)
    }
    
    func load(url: String?) {

        guard let link = url,
                let url = URL(string: link) else { return }

        openUrl(url)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
