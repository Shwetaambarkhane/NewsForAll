//
//  ArticleViewData.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 23/04/23.
//

import Foundation

class ArticleViewData {
    
    let articleDescription: String
    let articleURL: String
    
    init(articleDescription: String, articleURL: String) {
        self.articleDescription = articleDescription
        self.articleURL = articleURL
    }
}
