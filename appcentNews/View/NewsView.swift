//
//  NewsView.swift
//  appcentNews v0.2.0-alpha
//
//  Created by Giray Aksakal on 8.05.2024.
//

import SwiftUI

struct NewsView: View {
    @State var searchText: String = ""
    @StateObject var articleNewsViewModel = ArticleNewsVM()
    var text: String?
    @State var isFailed: Bool = false
    
    var body: some View {
        NavigationStack{
            ArticleListView(articles: articles)
                .onAppear {
                    Task.init {
                        await articleNewsViewModel.loadArticles()
                    }
                }
                .overlay(overlayView(isEmpty: isFailed))
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
            isFailed = true
            return []
        }
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            PlaceholderView(text: "Failed to fetch", image: Image(systemName: "network.slash"))
        }
    }
}

#Preview {
//    NewsView()
    ContentView()
        
}
