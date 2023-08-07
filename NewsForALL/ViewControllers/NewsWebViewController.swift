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
            assertionFailure("url cannot be nil")
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
        
        webView.load(webRequest)
    }
    
    override func loadView() {
        let webConfig = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.uiDelegate = self
        view = webView
    }
    
    func setupWebView() {
        let webView = WKWebView()
        view.addSubview(webView)
        self.webView = webView
    }
    
    func setupWebViewConstraints() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
