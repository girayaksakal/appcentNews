//
//  ArticleListView.swift
//  appcentNews
//
//  Created by Giray Aksakal on 11.05.2024.
//

import SwiftUI

struct ArticleListView: View {
    
    let articles: [Article]
    @State private var selectedArticle: Article?
    @State private var showDetails = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(articles) { article in
                    ArticleEachView(article: article)
                        .onTapGesture {
                            selectedArticle = article
                            showDetails = true
                        }
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
                
            }
            .navigationDestination(isPresented: $showDetails, destination: {
                InspectView(article: selectedArticle)
                Spacer()
            })
            .listStyle(.plain)
        }
    }
}
#Preview {
    ArticleListView(articles: Article.previewData)
}
