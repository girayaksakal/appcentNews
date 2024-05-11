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
    
}
