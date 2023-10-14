//
//  Article.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 20/08/23.
//

import Foundation

struct Article: Codable {
    
    var source: Source
    var title: String
    var description: String?
    var url: String
    var publishedAt: String
}

struct Source: Codable {
    var name: String
}
