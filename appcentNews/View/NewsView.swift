//
//  NewsView.swift
//  appcentNews
//
//  Created by Giray Aksakal on 8.05.2024.
//

import SwiftUI


struct NewsView: View {
    var body: some View {
        NavigationStack{
            ArticleListView(articles: Article.previewData)
                .navigationTitle("Appcent News")
            
        }
    }
}

#Preview {
//    NewsView()
    ContentView()
        
}
