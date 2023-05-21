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
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.popViewController(animated: false)
        self.dismiss(animated: false)
        self.present(vc, animated: false)
    }

}

