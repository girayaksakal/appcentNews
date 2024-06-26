//
//  appcentNewsApp.swift
//  appcentNews
//
//  Created by Giray Aksakal on 8.05.2024.
//

import SwiftUI

@main
struct appcentNewsApp: App {
    @StateObject var articleFavoriteViewModel = ArticleFavoritesVM.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleFavoriteViewModel)
        }
    }
}
