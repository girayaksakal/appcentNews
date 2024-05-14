//
//  ArticleSearchVM.swift
//  appcentNews v0.2.0-alpha
//
//  Created by Giray Aksakal on 13.05.2024.
//

import SwiftUI

@MainActor
class ArticleSearchVM: ObservableObject {
    @Published var phase: DataFetchPhase<[Article]> = .empty
    @Published var searchQuery = ""
    
    private let newsAPI = NewsAPI.shared
    
    func searchArticle() async {
        if Task.isCancelled { return }
        
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        
        do {
            let articles = try await newsAPI.fetch(query: searchQuery)
            if Task.isCancelled { return }
            phase = .success(articles)
        } catch {
            phase = .failure(error)
        }
    }
}
