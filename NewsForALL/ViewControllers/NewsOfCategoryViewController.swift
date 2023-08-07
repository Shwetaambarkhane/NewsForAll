//
//  NewsOfCategoryViewController.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 05/08/23.
//

import UIKit

class NewsOfCategoryViewController: NewsArticlesViewController {
    
    init(category: String) {
        let headers = [
            "X-BingApis-SDK": "true",
            "Accept-Language": "English",
            "X-RapidAPI-Key": "35e69d2f67mshfa8f9e7673f71f6p140f22jsn2cfd05349106",
            "X-RapidAPI-Host": "bing-news-search1.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://bing-news-search1.p.rapidapi.com/news/search?q=\(category)&freshness=Day&textFormat=Raw&safeSearch=Off")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        super.init(request: request)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
