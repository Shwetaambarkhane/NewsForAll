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
    private var newsData: [ArticleViewModel]?
    private var url: URL?
    
    lazy var refresher: UIRefreshControl = {
       let refresher = UIRefreshControl()
        refresher.tintColor = .black
        refresher.addTarget(self, action: #selector(createApi), for: .valueChanged)
        
        return refresher
    }()
    
    
    init(url: URL?) {
        self.url = url
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
        guard let url = url else {
            print("URL cannot be nil")
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            }
            
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let newsFeed = try decoder.decode(NewsFeed.self, from: content)
                let viewModel = NewsFeedViewModel(newsFeed: newsFeed)
                    
                self.newsData = viewModel.articleModels
                if self.newsData != nil {
                    DispatchQueue.main.async {
                        self.collectionView.invalidateIntrinsicContentSize()
                        self.collectionView.reloadData()//Reload here
                        self.refresher.endRefreshing()
                    }
                }
            } catch {
                print("Error in JSON Parsing")
            }
            // update UI using the response here
        }
        dataTask.resume()
    }
    
    func didTrendingButtonTapped() {
        // No op
    }
    
    func didCategoriesButtonTapped() {
        let vc = NewsCategoriesViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    func didReadMoreButtonTapped(urlString: String) {
        let webVC = NewsWebViewController(urlString: urlString)
        webVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    func didPublisherLabelTapped(publishersList: [String]?) {
        let bottomSheetVC = PublishersBottomsheetController(publishersList: publishersList)
        bottomSheetVC.modalPresentationStyle = .formSheet
        present(bottomSheetVC, animated: true, completion: nil)
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
        guard let newsData = newsData else {
            print("No data")
            return 0
        }
        return newsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "articleCell",
            for: indexPath) as! ArticleCell
        cell.delegate = self
        
        guard let data = newsData else {
            print("No data")
            return UICollectionViewCell()
        }
        
        let viewdata = ArticleViewData(articleDescription: data[indexPath.row].title, articleURL: data[indexPath.row].url, publisher: data[indexPath.row].publisher)
        cell.bind(with: viewdata)
        return cell
    }

}
