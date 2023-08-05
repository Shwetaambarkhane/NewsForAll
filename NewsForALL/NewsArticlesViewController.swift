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
    weak var tabButtonsView: UIView!
    private var newsData = [Any]()
    private var request: NSMutableURLRequest
    
    
    init(request: NSMutableURLRequest) {
        self.request = request
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

extension NewsArticlesViewController: UICollectionViewDelegateFlowLayout {
    
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

extension NewsArticlesViewController: UICollectionViewDataSource {
    
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
