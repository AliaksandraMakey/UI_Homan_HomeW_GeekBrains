//
//  BigPhotosViewController.swift
//  UI_Homan_Homework
//
//  Created by aaa on 20.06.22.
//

import UIKit

class BigPhotosViewController: UIViewController {

    @IBOutlet weak var galleryView: BigPhotoViewXib!
        public var photoAlbum: [UIImage] = []
        public var selectedPhotoIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

                
        
        
//        let images = [UIImage(named: "Ron_Heart")!, UIImage(named: "Evil_book")!, UIImage(named: "Education")!, UIImage(named: "Hermione_Hi")!, UIImage(named: "Hermione_Kat")!, UIImage(named: "Hogwarts-1")!, UIImage(named: "Magic_Sticks")!, UIImage(named: "owl")!]
//        galleryView.setImages(images: images)
    
    }
    

}

