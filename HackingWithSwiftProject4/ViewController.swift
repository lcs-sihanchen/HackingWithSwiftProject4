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
    
    // Properties
    var webView: WKWebView!
    var progressView: UIProgressView!
    var theWebsites: [String]?
    var selectedWebsite: String?
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
        
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Have to start with https:// for it to process
        guard let websites = theWebsites else {
            return
        }
        guard let wesitesToLoad = selectedWebsite else {
            return
        }
        navigationItem.largeTitleDisplayMode = .never
        let url = URL(string: "https://" + (wesitesToLoad))!
            
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        
        // WebView progress (show how much is loaded)
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        
        // Set progress view value to its actual progress(a value from 0-1)
        
        // Self -- Who the observer is
        // forKeyPath --- What property we want to observe
        // nil --- the context that's sent back to us when a value is changed
        // addObserver() always comes with a removeObserver()
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        
        // Get a flexible space to put buttons in
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        
        // Get a refresh button, when tapped, webView reloads
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        let goBack = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        
        
        let goForward = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
        
        // Add those two into the tool bar items
        toolbarItems = [progressButton, spacer, goBack, goForward, refresh]
        
        // Show the hidden tool bar
        navigationController?.isToolbarHidden = false
        
        
    }
    
    // The function is using the values from the observer, and if there is any change, update the progress value?
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    @objc func openTapped() {
        guard let websites = theWebsites else {
            return
        }
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        // Apple.com option, Invoke openPage Function when tapped
        //        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        //        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default,
                                       handler: openPage))
        }
        // Cancel the option with a nil handler
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // an Ipad Method
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    // Load the page
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // Add webpage title to the title
        title = webView.title
    }
    
    
    // Not sure what this does
    func webView(_ webView: WKWebView, decidePolicyFor
        navigationAction: WKNavigationAction, decisionHandler:
        @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        guard let websites = theWebsites else {
            return
        }
        var a = 1
        // Not all urls have host
        if let host = url?.host {
            
            if a==1 {
                for website in websites {
                    if host.contains(website) {
                        decisionHandler(.allow)
                        a = 2
                        return
                    }
                }
                
            } else if a==2 {
                
                let ac = UIAlertController(title: "We are very sorry", message: "The website is blocked.", preferredStyle: .alert)
                
                ac.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
                
                present(ac, animated: true)
                webView.load(URLRequest(url: URL(string: "https://" + websites[0])!))
                
            }
        }
        
        decisionHandler(.cancel)
        
    }
    // Appear when view is on
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    // Disappear when view is hidden
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    
}
