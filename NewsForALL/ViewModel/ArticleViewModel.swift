//
//  ArticleViewModel.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 07/10/23.
//

import Foundation

class ArticleViewModel {
    
    private let article: Article

    init(article: Article) {
        self.article = article
    }
    
    var title: String {
        return article.title
    }

    var publisher: String {
        return article.source.name
    }

    var description: String? {
        return article.description
    }

    var url: String {
        return article.url
    }

    var formattedDate: Date? {
        let dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.date(from: article.publishedAt)
    }
}
