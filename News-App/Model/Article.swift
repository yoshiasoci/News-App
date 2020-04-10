//
//  Article.swift
//  News-App
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct ArticleResult: Decodable {
    var totalResults: Int
    var articles: [Article]
}

struct Article: Decodable {
    var title: String?
    var url: String
    var urlToImage: String?
}
