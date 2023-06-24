//
//  NewsWebViewController.swift
//  NewsForALL
//
//  Created by Shweta Ambarkhane on 22/06/23.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    var webRequest: URLRequest!
    
    init(urlString: String) {
        super.init(nibName: nil, bundle: nil)
        let url = URL(string: urlString)
        guard let url = url else {
            print("Hello - nil url")
            return
        }
        self.webRequest = URLRequest(url: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 10, height: UIScreen.main.bounds.height - 40))
        self.view.addSubview(webView)
        webView.backgroundColor = .green
        
        // Nav bar
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "SomeTitle")
        let backItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(tapBackButton))
        navItem.leftBarButtonItem = backItem
        
        navBar.setItems([navItem], animated: false)
        
        self.webView = webView
        self.webView.load(self.webRequest)
    }
    
    override func loadView() {
        let webConfig = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.uiDelegate = self
        self.view = webView
    }
    
    @objc
    func tapBackButton() {
        self.navigationController?.popViewController(animated: false)
    }
}
