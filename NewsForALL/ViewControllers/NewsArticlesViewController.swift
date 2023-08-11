//
//  NewsArticlesViewController.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 05/08/23.
//

import Foundation
import UIKit

class NewsArticlesViewController: UIViewController, TabButtonsViewDelegate, ArticleCellDelegate {

    weak var collectionView: UICollectionView!
    private var newsData = [Any]()
    private var request: NSMutableURLRequest
    
    lazy var refresher: UIRefreshControl = {
       let refresher = UIRefreshControl()
        refresher.tintColor = .black
        refresher.addTarget(self, action: #selector(createApi), for: .valueChanged)
        
        return refresher
    }()
    
    
    init(request: NSMutableURLRequest) {
        self.request = request
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCollectionView()

        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: "articleCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refresher
    }
    
    func setCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        self.collectionView = collectionView
    }
    
    @objc
    func createApi() {
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
            if self.newsData.first is [String : Any] {
                DispatchQueue.main.async {
                    self.collectionView.invalidateIntrinsicContentSize()
                    self.collectionView.reloadData()//Reload here
                    self.refresher.endRefreshing()
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
        vc.dismiss(animated: false)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didReadMoreButtonTapped(urlString: String) {
        let webVC = NewsWebViewController(urlString: urlString)
        webVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(webVC, animated: true)
    }
}

extension NewsArticlesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 16, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}

extension NewsArticlesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "articleCell",
            for: indexPath) as! ArticleCell
        cell.delegate = self
        
        guard let data = newsData[indexPath.row] as? [String : Any] else {
            print("No data")
            return UICollectionViewCell()
        }
        
        let viewdata = ArticleViewData(articleDescription: data["description"] as! String, articleURL: data["url"] as! String)
        cell.bind(with: viewdata)
        return cell
    }

}
