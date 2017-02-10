//
//  WebViewViewController.swift
//  MyTechNews
//
//  Created by Fredrick Ohen on 2/10/17.
//  Copyright © 2017 geeoku. All rights reserved.
//

import UIKit

class WebViewViewController: UIViewController {
  
  
  @IBOutlet weak var webView: UIWebView!
  var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()
      
      webView.loadRequest(URLRequest(url: URL(string: url!)!))

    }
}
 
