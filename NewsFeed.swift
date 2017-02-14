//
//  NewsFeed.swift
//  Small Day Login
//
//  Created by Mahendra L on 2/7/17.
//  Copyright © 2017 Mahendra L. All rights reserved.
//

import UIKit

class NewsFeed: UIViewController , UIWebViewDelegate {

    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var displayArea: UIWebView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        displayArea.delegate = self
        displayArea.frame = self.view.frame
        
        let url = NSURL(string:"https://news.google.co.in")
        let req = NSURLRequest(url:url as! URL)
        self.displayArea!.loadRequest(req as URLRequest)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView : UIWebView)
    {
        activity.startAnimating()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activity.stopAnimating()
        activity.alpha = 0
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
