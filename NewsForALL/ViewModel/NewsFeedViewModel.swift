//
//  NewsFeedViewModel.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 07/10/23.
//

import Foundation

class NewsFeedViewModel {
    // MARK: - Properties

    private var newsFeed: NewsFeed

    // MARK: - Initialization

    init(newsFeed: NewsFeed) {
        self.newsFeed = newsFeed
    }
    
    var articleModels: [ArticleViewModel]? {
        let articlesModelArr: [ArticleViewModel]? = newsFeed.articles?.map { ArticleViewModel(article: $0) } ?? nil
        return articlesModelArr
    }

}
