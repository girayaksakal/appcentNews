//
//  ContentView.swift
//  appcentNews v0.2.0-alpha
//
//  Created by Giray Aksakal on 8.05.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
                
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
        
    }
}

#Preview {
    ContentView()
}
