
import UIKit
import WebKit
import Realm
import RealmSwift

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        
        /// MARK: URLRequest
        var urlComponents = URLComponents(string: "https://oauth.vk.com/authorize")
        // второй вариант записи urlComponents, в этом случае знаения будут не опциональными urlComponents.scheme = "https" urlComponents.host = "oauth.vk.com"  urlComponents.path = "/authorize"
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: "51415744"),
            URLQueryItem(name: "display", value: "mobile"),
            // адрес куда нас перенаправить (чтобы понять, прошли мы авторизацию или нет.
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            // нам нужно получить в ответе(response_type) на запрос token.
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        guard let url = urlComponents?.url else {return}
        
        let request = URLRequest(url: url)
        // обращаемся к webView с просьбой исполнить запрос. Перед запросом необходимо подписаться на navigationDelegate.
        webView.load(request)
    }
    
    @objc func  tapFunction() {
        self.view.endEditing(true)
    }
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
        //если путь url = "/blank.html" и у него есть параметр fragment - продолжаем работу. Если нет - разрешаем дальше переход, но для регистрации:  decisionHandler(.allow)
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else {return}
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([ String: String ](), { partialResult, param in
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
            var myvalue = realm.objects(TokenRealm.self).map{$0}.count
            myvalue = myvalue + 1
            try realm.write {
                let expiresInDate = Date().addingTimeInterval(TimeInterval(expiresIn))
                let tokenRealm = TokenRealm()
                tokenRealm.id = myvalue
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
        print("TOKEN ---> \(token)")
        print(userID)
        
        performSegue(withIdentifier: fromWebVCToNewsVC, sender: self)
    }
}
