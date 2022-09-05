//
//import UIKit
//
//
//class LoginViewController: UIViewController {
//    // связываем компоненты view с кодом.  перед viewDidLoad используем связки вида Outlet
//    @IBOutlet weak var loginTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
//    @IBOutlet weak var signInButton: UIButton!
//
//
//    
//    
//    //MARK: func viewDidLoad
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        
//    // добавим распознаватели жестов на экран, чтобы активировать клавиатуру. target - место, где Recognizer будет искать заданную функцию при касании экрана
//    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
//      // метод, который позволяет при тапе на клавиатуру не учитывать нажатие на ячейку
//        tapRecognizer.cancelsTouchesInView = false
//        // для обработки касания cancelsTouchesInView
//        tapRecognizer.cancelsTouchesInView = false
//   // добавим элемент, с которого будет считываться нажатие. в нашем случае считывание будет с корневого view
//    self.view.addGestureRecognizer(tapRecognizer)
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        loginTextField.alpha = 0.0
//        passwordTextField .alpha = 0.0
//        signInButton.alpha = 0.0
//    }
//    
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        // добавим анимацию на  loginTextField
//        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
//            self.loginTextField.alpha = 1
//               self.view.layoutIfNeeded()
//           }, completion: nil)
//        // добавим анимацию на passwordTextField
//        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
//               self.passwordTextField.alpha = 1
//               self.view.layoutIfNeeded()
//           }, completion: nil)
//        // добавим анимацию на кнопку signInButton
//        UIView.animate(withDuration: 0.5, delay: 0.4, options: UIView.AnimationOptions.curveEaseOut, animations: {
//            self.signInButton.alpha = 1
//            self.view.layoutIfNeeded()
//        }, completion: nil)
//                
//    }
//    // и напишем соответствующую tapFunction функцию и добавить приставку @objc
//    
//    @objc func  tapFunction() {
//        //для того, чтобы убрать клавиатуру
//        self.view.endEditing(true)
//    }
//    
//    // после viewDidLoad используем связки Action.
//    @IBAction func comeInButton(_ sender: UIButton) {
//
////    // с помощью guard меняем опциональный тип LoginTextField.text и задаем условие перехода на след view
//////        guard let login = loginTextField.text,
//////              let password = passwordTextField.text
//////        else {return}
//////
//////        if login  == "Alex",
//////           password == "123" {
////            performSegue(withIdentifier: "toGreenSegueOne", sender: nil)
////            print ("Login success")
//////        } else  {
//////            loginTextField.backgroundColor = #colorLiteral(red: 0.5783603787, green: 0.17343238, blue: 0.2041929364, alpha: 1)
//////            passwordTextField.backgroundColor = #colorLiteral(red: 0.5783603787, green: 0.17343238, blue: 0.2041929364, alpha: 1) }
////            return
//        }
//}
//
