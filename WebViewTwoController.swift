

import UIKit
import WebKit

class WebViewTwoController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    let token = Session.instance.token
    let userID =  Session.instance.userId
    let groupGateway = GroupGateway()
    override func viewDidLoad() {
        super.viewDidLoad()
//        webView.navigationDelegate = self

       
      
    }
}

