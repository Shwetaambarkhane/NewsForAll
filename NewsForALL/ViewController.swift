//
//  ViewController.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 23/04/23.
//

import CoreData
import UIKit

class ViewController: UIViewController {
    
    // Reference to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var currentUsers: [CurrentUser]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCurrentUsers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = (currentUsers != nil && currentUsers!.count > 0) ? NewsTrendingViewController() : LoginViewController()
        navigationController?.popViewController(animated: false)
        dismiss(animated: false)
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    func fetchCurrentUsers() {
        do {
            currentUsers = try context.fetch(CurrentUser.fetchRequest())
        } catch {
            print("Unsuccessful current user fetch request")
        }
    }

}

