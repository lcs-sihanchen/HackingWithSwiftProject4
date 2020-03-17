//
//  ViewController.swift
//  HackingWithSwiftProject4
//
//  Created by Chen, Sihan on 2020-03-16.
//  Copyright © 2020 Chen, Sihan. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    override func loadView() {
       webView = WKWebView()
       webView.navigationDelegate = self
       view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string: "https://www.apple.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }


}

