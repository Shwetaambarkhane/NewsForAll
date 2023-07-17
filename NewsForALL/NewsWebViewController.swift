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
        setupWebView()
        setupWebViewConstraints()
        
        self.webView.load(self.webRequest)
    }
    
    override func loadView() {
        let webConfig = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.uiDelegate = self
        self.view = webView
    }
    
    func setupWebView() {
        let webView = WKWebView()
        self.view.addSubview(webView)
        self.webView = webView
    }
    
    func setupWebViewConstraints() {
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
