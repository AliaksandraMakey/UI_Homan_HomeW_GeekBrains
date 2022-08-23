//
//  WebViewTwoController.swift
//  UI_Homan_Homework
//
//  Created by aaa on 28.07.22.
//

import UIKit
import WebKit

class WebViewTwoController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    let token = Session.instance.token
    let userID =  Session.instance.userId
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        webView.navigationDelegate = self
        friendsGetRequests ()
        groupsGetRequests()
        photosGetRequests()
      
    }
}

