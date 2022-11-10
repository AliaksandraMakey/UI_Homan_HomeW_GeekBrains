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
    
    }
    

}

