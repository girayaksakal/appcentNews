//
//  NewsView.swift
//  appcentNews
//
//  Created by Giray Aksakal on 8.05.2024.
//

import SwiftUI

struct NewsView: View {
    @State var searchText: String = ""
    @StateObject var articleNewsViewModel = ArticleNewsVM()
    var text: String?
    
    var body: some View {
        NavigationStack{
            ArticleListView(articles: articles)
                .onAppear {
                    Task.init {
                        await articleNewsViewModel.loadArticles()
                    }
                }
                .navigationTitle("Appcent News")
            
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            Task.init {
                await articleNewsViewModel.loadArticles(query: searchText)
            }
        }
        
    }
    
    private var articles: [Article] {
        if case let .success(articles) = articleNewsViewModel.phase {
            return articles
        } else {
            return []
        }
    }
}

#Preview {
//    NewsView()
    ContentView()
        
}
