//
//  Article.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 20/08/23.
//

import Foundation

struct Article: Codable {
    
    var author: String?
    var title: String
    var description: String?
    var url: String
    var publishedAt: String
}
