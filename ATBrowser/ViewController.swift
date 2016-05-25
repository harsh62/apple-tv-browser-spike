//
//  ViewController.swift
//  ATBrowser
//
//  Created by Harshd on 2016-05-10.
//  Copyright © 2016 Hachi. All rights reserved.
//

import UIKit
import SafariServices


class ViewController: UIViewController, SFSafariViewControllerDelegate {

    var isAppleTV = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if isAppleTV {
            view.backgroundColor = UIColor.redColor()
            showWebView()
        }
        else {
            view.backgroundColor = UIColor.blueColor()
            showWebView()
        }
    }
    
    private var urlString:String = "https://youtube.com"
    func showSafariController() {
        let svc = SFSafariViewController(URL: NSURL(string: self.urlString)!)
        svc.delegate = self
        self.presentViewController(svc, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController)
    {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

    ///SHOW WEB VIEW
    
    private var webView:UIWebView!
    
    func showWebView() {
        webView = UIWebView(frame: self.view.frame)
        let url = NSURL(string: urlString)!
        webView.loadRequest(NSURLRequest(URL: url))
        self.view.addSubview(webView)
    }
}

