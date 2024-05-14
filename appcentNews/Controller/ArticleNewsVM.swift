//
//  ArticleNewsVM.swift
//  appcentNews v0.2.0-alpha
//
//  Created by Giray Aksakal on 12.05.2024.
//

import SwiftUI

enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}

struct FetchTaskToken: Equatable {
    var query: String?
    var token: Date
}

@MainActor
class ArticleNewsVM: ObservableObject {
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var fetchTaskToken: FetchTaskToken

    private let newsAPI = NewsAPI.shared
    
    init(articles: [Article]? = nil, query: String? = nil) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.fetchTaskToken = FetchTaskToken(query: query,token: Date())
    }
    
    func loadArticles(query: String? = nil) async {
        if Task.isCancelled { return }
        phase = .empty
        do {
            fetchTaskToken.query = query
            let articles = try await newsAPI.fetch(query: fetchTaskToken.query)
            if Task.isCancelled { return }
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            print(error.localizedDescription)
            phase = .failure(error)
        }
    }
}
