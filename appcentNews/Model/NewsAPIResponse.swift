//
//  NewsAPIResponse.swift
//  appcentNews
//
//  Created by Giray Aksakal on 11.05.2024.
//

import Foundation

struct NewsAPIResponse: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
}
