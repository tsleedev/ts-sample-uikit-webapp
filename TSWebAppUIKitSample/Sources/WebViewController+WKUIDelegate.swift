//
//  WebViewController+WKUIDelegate.swift
//  TSWebAppUIKitSample
//
//  Created by TAE SU LEE on 5/10/24.
//  Copyright © 2024 https://github.com/tsleedev . All rights reserved.
//

import Foundation
import WebKit

// MARK: - WKUIDelegate
extension WebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler()
        }
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            let webView = WKWebView(frame: .zero, configuration: configuration)
            let viewController = WebViewController(webView: webView)
            navigationController?.pushViewController(viewController, animated: true)
            return webView
        }
        return nil
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        guard var viewControllers = navigationController?.viewControllers,
              let index = viewControllers.firstIndex(where: { $0 == self })
        else { return }
        viewControllers.remove(at: index)
        navigationController?.setViewControllers(viewControllers, animated: true)
    }
}
