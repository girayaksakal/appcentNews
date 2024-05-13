//
//  ArticleFavoritesVM.swift
//  appcentNews
//
//  Created by Giray Aksakal on 13.05.2024.
//

import SwiftUI

@MainActor
class ArticleFavoritesVM: ObservableObject {
    @Published private(set) var favorites: [Article] = []
    private let favoritesStore = PlistDataStore<[Article]> (filename: "favorites")
    
    static let shared = ArticleFavoritesVM()
    private init () {
        Task.init {
            await load()
        }
    }
    
    private func load() async {
        favorites = await favoritesStore.load() ?? []
    }
    
    func isFavorited(for article: Article) -> Bool {
        favorites.first { article.id == $0.id } != nil
    }
    
    func addFavorites(for article: Article) {
        guard !isFavorited(for: article) else {
            return
        }
        
        favorites.insert(article, at: 0)
        favoritesUpdate()
    }
    
    func removeFavorites(for article: Article) {
        guard let index = favorites.firstIndex(where: { $0.id == article.id }) else {
            return
        }
        favorites.remove(at: index)
        favoritesUpdate()
    }
    
    func triggerUpdate(for article: Article) {
        favoritesUpdate()
    }
    
    private func favoritesUpdate() {
        let favorites = self.favorites
        Task.init {
            await favoritesStore.save(favorites)
        }
    }
}
