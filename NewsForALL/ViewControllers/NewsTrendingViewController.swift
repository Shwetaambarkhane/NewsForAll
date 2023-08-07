//
//  NewsTrendingViewController.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 23/04/23.
//

import Foundation
import UIKit

class NewsTrendingViewController: NewsArticlesViewController {
    
    weak var tabButtonsView: UIView!
    
    init() {
        let headers = [
            "X-BingApis-SDK": "true",
            "Accept-Language": "English",
            "X-RapidAPI-Key": "35e69d2f67mshfa8f9e7673f71f6p140f22jsn2cfd05349106",
            "X-RapidAPI-Host": "bing-news-search1.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://bing-news-search1.p.rapidapi.com/news/search?q=trending&freshness=Day&textFormat=Raw&safeSearch=Off")! as URL,
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
        navigationController?.navigationBar.barTintColor = UIColor(red: 110/255, green: 185/255, blue: 255/255, alpha: 1)
        navigationItem.title = "Trending"
        navigationController?.isNavigationBarHidden = false
        
        super.viewWillAppear(animated)
        setTabButtonsView()
    }
    
    func setTabButtonsView() {
        let buttonsView = TabButtonsView()
        buttonsView.delegate = self
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        NSLayoutConstraint.activate([
            buttonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonsView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonsView.heightAnchor.constraint(equalToConstant: 50)
        ])
        buttonsView.trendingButton.backgroundColor = .white
        let attrString = NSAttributedString(string: "Trending", attributes: [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
            .foregroundColor: UIColor.black
        ])
        buttonsView.trendingButton.setAttributedTitle(attrString, for: .normal)
        self.tabButtonsView = buttonsView
    }
}
