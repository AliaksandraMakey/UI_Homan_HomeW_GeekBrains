//
//  ViewController.swift
//  UI_Homan_Homework
//
//  Created by aaa on 18.05.22.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {
    // связываем компоненты view с кодом.  перед viewDidLoad используем связки вида Outlet
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
//    {
//        didSet {
//            webView.navigationDelegate = self
//        }
//    }
    
    
    //MARK: func viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // вызываем функцию
//        configureWebView()
        
    // добавим распознаватели жестов на экран, чтобы активировать клавиатуру. target - место, где Recognizer будет искать заданную функцию при касании экрана
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
      // метод, который позволяет при тапе на клавиатуру не учитывать нажатие на ячейку
        tapRecognizer.cancelsTouchesInView = false
        // для обработки касания cancelsTouchesInView
        tapRecognizer.cancelsTouchesInView = false
   // добавим элемент, с которого будет считываться нажатие. в нашем случае считывание будет с корневого view
    self.view.addGestureRecognizer(tapRecognizer)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginTextField.alpha = 0.0
        passwordTextField .alpha = 0.0
        signInButton.alpha = 0.0
    }
    
//    // создаем функцию для передачи URL в WKWebView
//    private func configureWebView() {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "oauth.vk.com"
//        urlComponents.path = "/authorize"
//
//        urlComponents.queryItems = [
//        URLQueryItem(name: "client_id", value: "1234567"),
//        URLQueryItem(name: "display", value: "mobile"),
//        URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
//        URLQueryItem(name: "scope", value: "262150"),
//        URLQueryItem(name: "response_type", value: "token"),
//        URLQueryItem(name: "v", value: "5.68") ]
//        let request = URLRequest(url: urlComponents.url!)
//        webView.load(request)
//    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // добавим анимацию на  loginTextField
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.loginTextField.alpha = 1
               self.view.layoutIfNeeded()
           }, completion: nil)
        // добавим анимацию на passwordTextField
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
               self.passwordTextField.alpha = 1
               self.view.layoutIfNeeded()
           }, completion: nil)
        // добавим анимацию на кнопку signInButton
        UIView.animate(withDuration: 0.5, delay: 0.4, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.signInButton.alpha = 1
            self.view.layoutIfNeeded()
        }, completion: nil)
                
    }
    // и напишем соответствующую tapFunction функцию и добавить приставку @objc
    
    @objc func  tapFunction() {
        //для того, чтобы убрать клавиатуру
        self.view.endEditing(true)
    }
    
    // после viewDidLoad используем связки Action.
    @IBAction func comeInButton(_ sender: UIButton) {

    // с помощью guard меняем опциональный тип LoginTextField.text и задаем условие перехода на след view
//        guard let login = loginTextField.text,
//              let password = passwordTextField.text
//        else {return}
//
//        if login  == "Alex",
//           password == "123" {
            performSegue(withIdentifier: "toGreenSegueOne", sender: nil)
            print ("Login success")
//        } else  {
//            loginTextField.backgroundColor = #colorLiteral(red: 0.5783603787, green: 0.17343238, blue: 0.2041929364, alpha: 1)
//            passwordTextField.backgroundColor = #colorLiteral(red: 0.5783603787, green: 0.17343238, blue: 0.2041929364, alpha: 1) }
            return
        }
}

//// создадим расширение, которое будет срабатывать при переходе на след страницу. View будет определять, можно ли ему пройти дальше или не пропускать на след View
//extension LoginViewController: WKNavigationDelegate {
//func webView(_ webView: WKWebView,
//             decidePolicyFor navigationResponse: WKNavigationResponse,
//             decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//    //если путь url = "/blank.html" и у него есть параметр fragment - продолжаем работу. Если нет - разрешаем дальше переход, но для регистрации:  decisionHandler(.allow)
//    guard let url = navigationResponse.response.url,
//          url.path == "/blank.html",
//          let fragment = url.fragment
//    else { decisionHandler(.allow)
//        return
//    }
//    // как только он зашел на "/blank.html" мы запускаем фрагмент
//    let params = fragment
//    // делим его на компоненты
//        .components(separatedBy: "&")
//    // далее делим полученный массив еще на массивы
//        .map { $0.components(separatedBy: "=") }
//    // после вызываем функцию reduce, где из массивов делаем словарь
//        .reduce([String: String]()) { result, param in
//            var dict = result
//            let key = param[0]
//            let value = param[1]
//            dict[key] = value
//            return dict
//        }
//    // после чего мы забираем из этого словаря значение по ключу "access_token"
//    let token = params["access_token"];
//    print(token)
//    decisionHandler(.cancel) }
//}
