//
//  HomeViewController.swift
//  UI_Homan_Homework
//
//  Created by aaa on 16.06.22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var loadingOneImage: UIImageView!
    @IBOutlet weak var loadingTwoImage: UIImageView!
    @IBOutlet weak var loadingThreeImage: UIImageView!
    @IBOutlet weak var loadingFourImage: UIImageView!
    
    func loadingAnimateKeyframe(exitAfter: Int, currentCount: Int) {
        UIImageView.animateKeyframes(withDuration: 3,
                                     delay: 0,
                                     options: []) {
            UIImageView.addKeyframe(withRelativeStartTime: 0.2,
                                    relativeDuration: 0.2)  { [weak self] in
                self?.loadingOneImage.alpha = 0
                self?.loadingTwoImage.alpha = 0.5
            }
            UIImageView.addKeyframe(withRelativeStartTime: 0.4,
                                    relativeDuration: 0.2)  { [weak self] in
                self?.loadingTwoImage.alpha = 0
                self?.loadingThreeImage.alpha = 0.5
            }
            UIImageView.addKeyframe(withRelativeStartTime: 0.6,
                                    relativeDuration: 0.2)  { [weak self] in
                self?.loadingThreeImage.alpha = 0
                self?.loadingFourImage.alpha = 0.5
            }
            
            UIImageView.addKeyframe(withRelativeStartTime: 0.8,
                                    relativeDuration: 0.2)  { [weak self] in
                self?.loadingFourImage.alpha = 0
                self?.loadingOneImage.alpha = 0.5
            }
        } completion: {  [weak self] _ in
            if currentCount < exitAfter {
                self?.loadingAnimateKeyframe(exitAfter: exitAfter, currentCount: currentCount + 1)
            } else {
                self?.loadingOneImage.alpha = 0
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.0949761793, green: 0.1916104257, blue: 0.1280282736, alpha: 1)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadingOneImage.alpha = 0.2
        loadingTwoImage.alpha = 0.2
        loadingThreeImage.alpha = 0.2
        loadingFourImage.alpha = 0.2
        loadingAnimateKeyframe(exitAfter: 5, currentCount: 0)
    }
}






