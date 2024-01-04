//
//  AppDelegateHelper.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 17/10/23.
//

import Foundation

class AppDelegateHelper {
    
    func createApi() -> [ArticleViewModel]? {
        let url = URL(string:"https://newsapi.org/v2/everything?domains=techcrunch.com&apiKey=b966706827474443909530ca0afee468")
        
        let vc = NewsArticlesViewController(url: url)
        vc.createApi()
        return vc.getNewsData()
    }
}
