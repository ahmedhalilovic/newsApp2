//
//  ArticleView.swift
//  NewsAppTwo
//
//  Created by Ahmed Halilovic on 8. 9. 2024..
//

import SwiftUI
import URLImage

struct ArticleView: View {
    let article: Article
    
    var body: some View {
        HStack {
            if let imgUrl = article.urlToImage,
               let url = URL(string: imgUrl) {
                
                URLImage(url) {
                    EmptyView()
                } inProgress: { progress in
                    Text("Loading...")
                } failure: { error, _ in
                    PlacehoderImageView()
                } content: { image in
                    image
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .leading)
                }
                .cornerRadius(10)
            } else {
                
                PlacehoderImageView()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(article.title)
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                Text(article.publishedAt ?? "N/A")
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
        }
    }
}

struct PlacehoderImageView: View {
   
    var body: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.gray)
            .frame(width: 80, height: 80)
            .font(.system(size: 20))
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article.dummyData)
    }
}
