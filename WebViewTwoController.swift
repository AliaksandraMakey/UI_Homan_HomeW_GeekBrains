

import UIKit
import WebKit

class WebViewTwoController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    let token = Session.instance.token
    let userID =  Session.instance.userId
    let friendGateway = FriendGateway()
    let groupeGateway = GroupGateway()
    override func viewDidLoad() {
        super.viewDidLoad()
//        webView.navigationDelegate = self
        let friends = friendGateway.getFriends()
        for friend in friends {
            photosGetRequests(id: friend.id)
        }
        groupeGateway.getGroups()
       
      
    }
}

