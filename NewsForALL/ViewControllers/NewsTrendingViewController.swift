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
    
    // Reference to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var currentUsers: [CurrentUser]?
    
    init() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=b966706827474443909530ca0afee468")
        super.init(url: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrentUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Trending"
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.configureWithOpaqueBackground()
        barAppearance.backgroundColor = UIColor(red: 110/255, green: 185/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        navigationController?.navigationBar.standardAppearance = barAppearance
        
        let logoutImage = UIImage(named: "Logout")
        let button = UIButton(type: .custom)
        button.setImage(logoutImage, for: .normal)
        button.addTarget(self, action: #selector(logout), for: .allTouchEvents)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 30),
            button.widthAnchor.constraint(equalToConstant: 30)
        ])
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
        
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
    func logout() {
        if currentUsers != nil && currentUsers!.count > 0 {
            context.delete(currentUsers![0])
        }
        
        // save context
        do {
            try context.save()
        } catch {
            print("Unsuccessful save request")
        }
        
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.navigationController?.dismiss(animated: false)
        present(vc, animated: true)
    }
    
    func fetchCurrentUsers() {
        do {
            currentUsers = try context.fetch(CurrentUser.fetchRequest())
        } catch {
            print("Unsuccessful current user fetch request")
        }
    }
}
