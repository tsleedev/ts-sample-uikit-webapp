//
//  WebViewController.swift
//  TSWebAppUIKitSample
//
//  Created by TAE SU LEE on 5/10/24.
//  Copyright © 2024 https://github.com/tsleedev/. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    let webView: WKWebView
    
    // MARK: - Initialize with WebView
    init(webView: WKWebView) {
        self.webView = webView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        configureUI()
    }
}

// MARK: - Setup
private extension WebViewController {
    /// Initialize and add subviews
    func setupViews() {
        view.addSubview(webView)
        webView.uiDelegate = self
    }
    
    /// Set up Auto Layout constraints
    func setupConstraints() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    /// Initialize UI elements and localization
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
}
