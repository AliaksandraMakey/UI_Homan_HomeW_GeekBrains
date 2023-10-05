
import UIKit
import WebKit
import Realm
import RealmSwift

//FIXME: clean viewDidLoad

class WebViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var webView: WKWebView!
    //MARK:  viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        ///UITapGestureRecognizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        
        //MARK: URLRequest
        /// urlComponents
        var urlComponents = URLComponents(string: "https://oauth.vk.com/authorize")
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: "51623977"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents?.url else {return}
        /// request
        DispatchQueue.main.async {
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
    /// tapFunction
    @objc func  tapFunction() {
        self.view.endEditing(true)
    }
}
//MARK: extension WebViewController
extension WebViewController: WKNavigationDelegate {
    /// webView
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
        guard let
              url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else {return}
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([ String: String ](),
                    {
                partialResult, param in
                       var dictionary = partialResult
                       let key = param[0]
                       let value = param[1]
                       dictionary[key] = value
                return dictionary
            })
        guard
            let token = params["access_token"],
            let userIDString = params["user_id"],
            let expiresInString = params["expires_in"],
            let userID = Int(userIDString),
            let expiresIn = Int(expiresInString)
        else { return }
        
        do {
            let realm = try Realm()
            var myValue = realm.objects(TokenRealm.self).map{$0}.count
            myValue = myValue + 1
            try realm.write {
                let expiresInDate = Date().addingTimeInterval(TimeInterval(expiresIn))
                let tokenRealm = TokenRealm()
                tokenRealm.id = myValue
                tokenRealm.token = token
                tokenRealm.createdAt = Date()
                tokenRealm.expiresInDate = expiresInDate
                tokenRealm.userId = userID
                realm.add(tokenRealm)
                Session.instance.token = token
                Session.instance.userId = userID
                Session.instance.expiresInDate = expiresInDate
            }
        } catch {
            print(error)
        }
        print("token ---> \(token)")
        print(userID)
        
        performSegue(withIdentifier: fromWebVCToNewsVC, sender: self)
    }
}
