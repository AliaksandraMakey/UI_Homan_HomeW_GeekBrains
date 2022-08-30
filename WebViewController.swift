
import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        
        // добавим распознаватели жестов на экран, чтобы активировать клавиатуру. target - место, где Recognizer будет искать заданную функцию при касании экрана
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        // метод, который позволяет при тапе на клавиатуру не учитывать нажатие на ячейку
        tapRecognizer.cancelsTouchesInView = false
        // для обработки касания cancelsTouchesInView
        tapRecognizer.cancelsTouchesInView = false
        // добавим элемент, с которого будет считываться нажатие. в нашем случае считывание будет с корневого view
        self.view.addGestureRecognizer(tapRecognizer)
        
        /// MARK: URLRequest
        //вводим адрес авторизации
        var urlComponents = URLComponents(string: "https://oauth.vk.com/authorize")
        // второй вариант записи urlComponents, в этом случае знаения будут не опциональными urlComponents.scheme = "https" urlComponents.host = "oauth.vk.com"  urlComponents.path = "/authorize"
   
  
        // вводим остальные параметры
        urlComponents?.queryItems = [
        URLQueryItem(name: "client_id", value: "8228489"),
        URLQueryItem(name: "display", value: "mobile"),
        // адрес куда нас перенаправить (чтобы понять, прошли мы авторизацию или нет.
        URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
        URLQueryItem(name: "scope", value: "262150"),
        // нам нужно получить в ответе(response_type) на запрос token.
        URLQueryItem(name: "response_type", value: "token"),
        URLQueryItem(name: "v", value: "5.68")
        ]
        //далее создаем url из компонентов
        guard let url = urlComponents?.url else {return}
     
        // создаем запрос
        let request = URLRequest(url: url)
        // обращаемся к webView с просьбой исполнить запрос. Перед запросом необходимо подписаться на navigationDelegate.
        webView.load(request)

    }
    @objc func  tapFunction() {
        //для того, чтобы убрать клавиатуру
        self.view.endEditing(true)
    }
    

}

// так как мы подписались на navigationDelegate создадим расширение. Оно будет срабатывать при переходе на след страницу. View будет определять, можно ли ему пройти дальше или не пропускать на след View
extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
        //если путь url = "/blank.html" и у него есть параметр fragment - продолжаем работу. Если нет - разрешаем дальше переход, но для регистрации:  decisionHandler(.allow)
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else {return}
        // как только он зашел на "/blank.html" мы запускаем фрагмент
        let params = fragment
        // делим его на компоненты
            .components(separatedBy: "&")
        // далее делим полученный массив еще на массивы
            .map { $0.components(separatedBy: "=") }
        // после вызываем функцию reduce, где из массивов делаем словарь
            .reduce([ String: String ](), { partialResult, param in
                var dictionary = partialResult
                let key = param[0]
                let value = param[1]
                dictionary[key] = value
                return dictionary
            })
        // после чего мы забираем из этого словаря значение по ключу "access_token"
        guard
            let token = params["access_token"],
            let userIDString = params["user_id"],
            let userID = Int(userIDString)
        else { return }
        // обьявляем singlton и присваеваем ему значения из полученных данных
        Session.instance.token = token
        Session.instance.userId = userID
        
        
        print("TOKEN ---> \(token)")
        print(userID)
        
        performSegue(withIdentifier: "fromWebViewToWebViewTwo", sender: self)
    }

    
}
