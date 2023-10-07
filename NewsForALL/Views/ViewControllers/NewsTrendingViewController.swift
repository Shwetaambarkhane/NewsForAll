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
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=b966706827474443909530ca0afee468")
        super.init(url: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Trending"
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.configureWithOpaqueBackground()
        barAppearance.backgroundColor = UIColor(red: 110/255, green: 185/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        navigationController?.navigationBar.standardAppearance = barAppearance
        
        let navigationComponents = NavigationComponents()
        let profilebutton = navigationComponents.createProfileButton()
        profilebutton.addTarget(self, action: #selector(tapProfileButton), for: .touchUpInside)
        let profilebarButton = UIBarButtonItem(customView: profilebutton)
        navigationItem.leftBarButtonItem = profilebarButton
        
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
    
    @objc
    func tapProfileButton() {
        let vc = ProfileViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}
