//
//  NewsFeed.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 20/08/23.
//

import Foundation

struct NewsFeed : Codable {
    
    var status: String = ""
    var totalResults: Int = 0
    var articles: [Article]?
}
