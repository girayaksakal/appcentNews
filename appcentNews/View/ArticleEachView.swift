//
//  ArticleEachView.swift
//  appcentNews
//
//  Created by Giray Aksakal on 11.05.2024.
//

import SwiftUI

struct ArticleEachView: View {
    
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // MARK: - ARTICLE IMAGE
            AsyncImage(url: article.imageURL) { phase in
                switch phase {
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure(_):
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                            .imageScale(.large)
                        Spacer()
                    }
                @unknown default:
                    fatalError()
                }
            }
            .frame(minWidth: 200, minHeight: 100)
            .background(Color.gray.opacity(0.3))
            
            VStack(alignment: .leading, spacing: 8) {
                //  MARK: - ARTICLE TITLE
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)
                
                //  MARK: - ARTICLE DESCRIPTION
                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(2)

                // MARK: - ARTICLE SOURCE AND DATE
                HStack {
                    Text(article.source.name)
                    Spacer()
                    Text(article.relativeDate)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .padding()
        }
    }
}

#Preview {
    List {
        ArticleEachView(article: .previewData[0])
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    .listStyle(.plain)
}
