//
//  Source.swift
//  News-App
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct SourceResult: Decodable {
    var sources: [Source]
}

struct Source: Decodable {
    var id: String
    var name: String
    var description: String
    var url: String
}
