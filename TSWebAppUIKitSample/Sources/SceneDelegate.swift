//
//  SceneDelegate.swift
//  TSWebAppUIKitSample
//
//  Created by TAE SU LEE on 5/10/24.
//  Copyright © 2024 https://github.com/tsleedev . All rights reserved.
//

import UIKit
import WebKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let htmlPath = Bundle.main.path(forResource: "testHtml", ofType: "html")!
        let url = URL(fileURLWithPath: htmlPath)
        let request = URLRequest(url: url)
        let webView = WKWebView()
        webView.load(request)
        
        let viewController = WebViewController(webView: webView)
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
