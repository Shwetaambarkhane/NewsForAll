//
//  ViewController.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 23/04/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = NewsTrendingViewController()
        self.navigationController?.popViewController(animated: false)
        self.dismiss(animated: false)
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }

}

