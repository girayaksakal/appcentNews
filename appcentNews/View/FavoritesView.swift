//
//  FavoritesView.swift
//  appcentNews v0.2.0-alpha
//
//  Created by Giray Aksakal on 8.05.2024.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var articleFavoriteViewModel: ArticleFavoritesVM
    
    var body: some View {
        NavigationStack {
            ArticleListView(articles: articleFavoriteViewModel.favorites)
                .overlay(overlayView(isEmpty: articleFavoriteViewModel.favorites.isEmpty))
                .navigationTitle("Favorites")
        }
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            PlaceholderView(text: "It's lonely here", image: Image(systemName: "heart"))
        }
    }
}

#Preview {
//    FavoritesView()
    ContentView()
}
