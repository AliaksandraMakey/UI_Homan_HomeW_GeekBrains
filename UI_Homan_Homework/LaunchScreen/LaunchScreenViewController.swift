//
//  LaunchScreenViewController.swift
//  UI_Homan_Homework
//
//  Created by aaa on 08.06.22.
//

import UIKit

class LaunchScreenViewController: UIViewController {
   
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "loading")
        return imageView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.backgroundColor = .green
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:  {
            self.animate()
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
    }

    private func animate() {
        UIImageView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 1.5
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.width - size
            self.imageView.frame = CGRect(x: -(diffX / 2), y: diffY / 2, width: size, height: size)
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute:  {
                let viewController = LoginViewController()
                self.present(viewController, animated: true)
                                              })
            }
        })

        self.imageView.alpha = 1
        
      
    }
}
