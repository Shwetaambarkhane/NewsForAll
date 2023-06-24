//
//  NewsInfoViewData.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 21/05/23.
//

import Foundation

class NewsInfoViewData {
    
    let tabType: String
    let allArticles: [ArticleViewData]
    
    init(tabType: String, allArticles: [ArticleViewData]) {
        self.tabType = tabType
        self.allArticles = allArticles
    }
    
}
