//
//  WebVC.swift
//  SwiftProtein
//
//  Created by Dmytro Ryshchuk on 10/13/19.
//  Copyright © 2019 Dmytro Ryshchuk. All rights reserved.
//

import UIKit
import WebKit

class WebVC: UIViewController, WKUIDelegate, WKNavigationDelegate {

    private var webView = WKWebView()
    var proteinName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = proteinName
        showWebView()
    }
    
    private func showWebView() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), configuration: WKWebViewConfiguration.init())
        let website = navigationItem.title ?? "10r"
        let openUrl = "https://www.rcsb.org/ligand/\(website)"
        print("\n\n\(openUrl)\n\n")
        let url = URL(string: openUrl)
        webView.load(URLRequest(url: url!))
        view.addSubview(webView)
    }
}
