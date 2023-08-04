//
//  NewsTrendingViewController.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 23/04/23.
//

import Foundation
import UIKit

class NewsTrendingViewController: UIViewController, TabButtonsViewDelegate, ArticleCellDelegate {

    weak var collectionView: UICollectionView!
    weak var tabButtonsView: UIView!
    private var newsData = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 110/255, green: 185/255, blue: 255/255, alpha: 1)
        self.navigationItem.title = "Trending"
        self.navigationController?.isNavigationBarHidden = false
        self.setCollectionView()
        self.setTabButtonsView()

        self.collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func setCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        self.collectionView = collectionView
    }
    
    func setTabButtonsView() {
        let buttonsView = TabButtonsView()
        buttonsView.delegate = self
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(buttonsView)
        NSLayoutConstraint.activate([
            buttonsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            buttonsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            buttonsView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        buttonsView.trendingButton.backgroundColor = .white
        let attrString = NSAttributedString(string: "Trending", attributes: [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
            .foregroundColor: UIColor.black
        ])
        buttonsView.trendingButton.setAttributedTitle(attrString, for: .normal)
        self.tabButtonsView = buttonsView
    }
    
    func createApi() {
        let headers = [
            "X-BingApis-SDK": "true",
            "Accept-Language": "English",
            "X-RapidAPI-Key": "35e69d2f67mshfa8f9e7673f71f6p140f22jsn2cfd05349106",
            "X-RapidAPI-Host": "bing-news-search1.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://bing-news-search1.p.rapidapi.com/news/search?q=Sports&freshness=Day&textFormat=Raw&safeSearch=Off")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            }
            
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }

            // serialise the data / NSData object into Dictionary [String : Any]
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }

            self.newsData = json["value"] as! [Any]
            if let first = self.newsData.first as? [String : Any] {
                print(first)
                DispatchQueue.main.async {
                    self.collectionView.invalidateIntrinsicContentSize()
                    self.collectionView.reloadData()//Reload here
                }
            }
            // update UI using the response here
        })
        dataTask.resume()
    }
    
    func didTrendingButtonTapped() {
        // No op
    }
    
    func didCategoriesButtonTapped() {
        let vc = NewsCategoriesViewController()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.popViewController(animated: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didReadMoreButtonTapped(urlString: String) {
        let webVC = NewsWebViewController(urlString: urlString)
        webVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}

extension NewsTrendingViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row + 1)
    }
}

extension NewsTrendingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath) as! ArticleCell
        return CGSize(width: collectionView.bounds.size.width - 16, height: cell.cellHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}

extension NewsTrendingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath) as! ArticleCell
        cell.delegate = self
        
        guard let data = self.newsData[indexPath.row] as? [String : Any] else {
            print("No data")
            return UICollectionViewCell()
        }
        
        let viewdata = ArticleViewData(articleDescription: data["description"] as! String, articleURL: data["url"] as! String)
        cell.bind(with: viewdata)
        return cell
    }
}
