//
//  InspectView.swift
//  appcentNews v0.2.0-alpha
//
//  Created by Giray Aksakal on 11.05.2024.
//

import SwiftUI

struct InspectView: View {
    let article: Article?
    
    @State private var viewOnSource = false
        
    @EnvironmentObject var articleFavoriteViewModel: ArticleFavoritesVM
    
    var articleNonOptional: Article {
        article ?? .previewData[0]
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // MARK: - ARTICLE IMAGE
                AsyncImage(url: article?.imageURL) { phase in
                    switch phase {
                    case .empty:
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure(_):
                        HStack {
                            Spacer()
                            Image(systemName: "photo")
                                .imageScale(.large)
                            Spacer()
                        }
                    @unknown default:
                        fatalError()
                    }
                }
            }
//            .frame(minWidth: 200, minHeight: 300)
            
            VStack(alignment: .leading) {
                Text(articleNonOptional.title)
                    .font(.headline)
                    .fontWeight(.bold)
                
                HStack {
                    Image(systemName: "newspaper.fill")
                        .imageScale(.large)
                    Text(articleNonOptional.authorText)
                    
                    Spacer()
                    
                    Image(systemName: "calendar")
                        .imageScale(.large)
                    Text(articleNonOptional.relativeDate)

                }
                .padding(.vertical)
                .foregroundStyle(.secondary)
                
                Text(articleNonOptional.contentText)
                
            }
            
            Button(action: {
                viewOnSource = true
            }, label: {
                Text("Continue on source")
            })
            .padding(.top)
            .sheet(isPresented: $viewOnSource, content: {
                WebView(url: articleNonOptional.articleURL)
                    .ignoresSafeArea(edges: .bottom)
            })
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    shareButtonTapped(url: articleNonOptional.articleURL)
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                })
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    favButtonTapped(for: articleNonOptional)
                } , label: {
                    Image(systemName: articleFavoriteViewModel.isFavorited(for: articleNonOptional) ? "heart.fill" : "heart")
                })
            }
        }
        .padding()
        
    }
    
    private func favButtonTapped(for article: Article) {
        let generator = UINotificationFeedbackGenerator()
        if articleFavoriteViewModel.isFavorited(for: article) {
            articleFavoriteViewModel.removeFavorites(for: article)
        } else {
            articleFavoriteViewModel.addFavorites(for: article)
        }
        
        generator.notificationOccurred(.success)
    }
}

extension View {
    func shareButtonTapped(url: URL) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
}

#Preview {
    InspectView(article: .previewData[0])
}
#Preview {
    ContentView()
}

