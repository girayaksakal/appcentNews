//
//  Article.swift
//  appcentNews v0.2.0-alpha
//
//  Created by Giray Aksakal on 9.05.2024.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct Article: Codable, Equatable, Identifiable{
    
    // This id will be unique and auto generated from client side to avoid clashing of Identifiable in a List as NewsAPI response doesn't provide unique identifier
    let id = UUID()
    
    let source: ArticleSource
    let title: String
    let author: String?
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source
        case title
        case author
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
    
    var authorText: String {
        author ?? ""
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    var contentText: String {
        content ?? ""
    }
    
    
    var relativeDate: String {
        "\(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
    
    var articleURL: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
}

extension Article {
    static var previewData: [Article] {
        let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(NewsAPIResponse.self, from: data)
        return apiResponse.articles ?? []
    }
}

struct ArticleSource: Codable, Equatable {
    let name: String
}


