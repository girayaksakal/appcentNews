//
//  PlaceholderView.swift
//  appcentNews v0.2.0-alpha
//
//  Created by Giray Aksakal on 13.05.2024.
//

import SwiftUI

struct PlaceholderView: View {
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            if let image = self.image {
                image
                    .imageScale(.large)
                    .font(.system(size: 52))
            }
            Text(text)
            Spacer()
        }
    }
}

#Preview {
    PlaceholderView(text: "No Favorites", image: Image(systemName: "heart.fill"))
}
