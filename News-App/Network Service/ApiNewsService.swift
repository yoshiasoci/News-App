//
//  ApiNewsService.swift
//  News-App
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Moya

public let apiKey: String = "9c8fb6aedc804f019f4e93c5047bb594" // <- AccessKey

enum ApiNewsService {
    case getNewsSource(apiKey: String, category: String)
    case getNewsArticle(apiKey: String, sources: String, page: Int)
    case getTopHeadlines(apiKey: String, country: String, page: Int)
    case searchNewsArticle(apiKey: String, query: String, page: Int)
}

extension ApiNewsService: TargetType {
    var baseURL: URL {
        return URL(string: "https://newsapi.org")!
    }
    
    var path: String {
        switch self {
        case .getNewsSource(_, _):
            return "/v2/sources"
        case .getNewsArticle(_, _, _):
            return "/v2/everything"
        case .getTopHeadlines(_, _, _):
            return "/v2/top-headlines"
        case .searchNewsArticle(_, _, _):
            return "/v2/everything"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNewsSource(_, _),
             .getNewsArticle(_, _, _),
             .getTopHeadlines(_, _, _),
             .searchNewsArticle(_, _, _):
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getNewsSource(let apiKey, let category):
            return "\(apiKey), \(category)".data(using: .utf8)!
        case .getNewsArticle(let apiKey, let source, let page):
            return "\(apiKey), \(source), \(page)".data(using: .utf8)!
        case .getTopHeadlines(let apiKey, let country, let page):
            return "\(apiKey), \(country), \(page)".data(using: .utf8)!
        case .searchNewsArticle(let apiKey, let query, let page):
            return "\(apiKey), \(query), \(page)".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .getNewsSource(let apiKey, let category):
            return .requestParameters(parameters: ["apiKey" : "\(apiKey)", "category" : "\(category)"], encoding: URLEncoding.default)
        case .getNewsArticle(let apiKey, let sources, let page):
            return .requestParameters(parameters: ["apiKey" : "\(apiKey)", "sources" : "\(sources)", "page" : "\(page)"], encoding: URLEncoding.default)
        case .getTopHeadlines(let apiKey, let country, let page):
            return .requestParameters(parameters: ["apiKey" : "\(apiKey)", "country" : "\(country)", "page" : "\(page)"], encoding: URLEncoding.default)
        case .searchNewsArticle(let apiKey, let query, let page):
            return .requestParameters(parameters: ["apiKey" : "\(apiKey)", "q" : "\(query)", "page" : "\(page)"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
