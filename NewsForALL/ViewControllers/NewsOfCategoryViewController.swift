//
//  NewsOfCategoryViewController.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 05/08/23.
//

import UIKit

class NewsOfCategoryViewController: NewsArticlesViewController {
    
    let category: String
    
    init(category: String) {
        self.category = category
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&apiKey=b966706827474443909530ca0afee468")
        super.init(url: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "\(category)"
        
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
