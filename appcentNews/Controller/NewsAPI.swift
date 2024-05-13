//
//  NewsAPI.swift
//  appcentNews
//
//  Created by Giray Aksakal on 8.05.2024.
//

import Foundation

struct NewsAPI {
    static let shared = NewsAPI()
    private init() {}
    
    private let apiKey = Bundle.main.infoDictionary?["NEWSAPI_KEY"]
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetch(query: String?) async throws -> [Article] {
        try await fetchArticles(from: generateURL(query: query))
        
    }
    
    private func fetchArticles(from url: URL) async throws -> [Article] {
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw NSError(domain: "NewsAPI", code: -1, userInfo: [NSLocalizedDescriptionKey: "Bad Response"])
        }
        
        switch response.statusCode {
        case (200...299), (400...499):
            let apiResponse = try jsonDecoder.decode(NewsAPIResponse.self, from: data)
            if apiResponse.status == "ok" {
                return apiResponse.articles ?? []
            } else {
                throw NSError(domain: "NewsAPI", code: 1, userInfo: [NSLocalizedDescriptionKey: apiResponse.message ?? "An error occured"])
            }
        default:
            throw NSError(domain: "NewsAPI", code: 1, userInfo: [NSLocalizedDescriptionKey: "An error occured"])
        }
    }
    
    // MARK: - Generate URL with or without query
    func generateURL(query: String?) -> URL {
        let percentEncodedString = query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        var url = "https://newsapi.org/v2/"
        if let input = percentEncodedString {
           url += "everything?q=\(input)&"
        } else {
            url += "top-headlines?"
            // !!!: Reason I'm not using tr as country parameter is because newsapi mostly relies on google news to provide Turkish news but since google news redirects to source its hard to get news' images.
            url += "country=us&"
        }
        url += "apiKey=\(apiKey ?? "")"
        return URL(string: url)!
    }
}

