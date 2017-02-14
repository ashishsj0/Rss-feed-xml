//
//  PostViewController.swift
//  BlogReader
//
// Created by Ashish Sharma on 2/6/17.
//  Copyright © 2017 Ashish All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var webView:UIWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var postLink: String = String()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let url: URL = URL(string: postLink)!
        let request: URLRequest = URLRequest(url: url)
        webView.loadRequest(request)
        webView.delegate = self
    }
    
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
