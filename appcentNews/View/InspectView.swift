//
//  InspectView.swift
//  appcentNews
//
//  Created by Giray Aksakal on 11.05.2024.
//

import SwiftUI

struct InspectView: View {
    let article: Article?
    @State private var viewOnSource = false
    @State private var saved = false
    
    
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
                Button(action: shareButtonTapped, label: {
                    Image(systemName: "square.and.arrow.up")
                })
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: favButtonTapped, label: {
                    if saved {
                        Image(systemName: "hearth.fill")
                    } else {
                        Image(systemName: "heart")
                    }
                    
                })
            }
        }
        .padding()
        
    }
    
    func shareButtonTapped() {}
    
    func favButtonTapped() {}
}

#Preview {
    InspectView(article: .previewData[0])
}
#Preview {
    ContentView()
}

