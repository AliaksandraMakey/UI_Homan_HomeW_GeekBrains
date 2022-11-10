//
//  GalleryCollectionCell.swift
//  UI_Homan_Homework
//
//  Created by aaa on 26.05.22.
//

import UIKit

class GalleryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var likeCounter: UILabel!
    @IBOutlet weak var likeCounterView: UIView!
    
    // пишем функцию для переиспользования ячейки
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
        
    }
    // добавим нажатие на heart со сменой цвета
    @IBAction func pressHeartButton(_ sender: Any) {
        guard let button = sender as? UIButton else {return}
        if likeEnable {
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            counter -= 1
            likeCounter.text = String(counter)
        } else {
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            UIView.transition(with: likeCounterView, duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: { self.likeCounterView.frame },
                              completion: nil)
        }
        counter += 1
        likeCounter.text = String(counter)
//        likeEnable = !likeEnable
    }
        
        
    //конфигурируем ячейку, в которой фото будем брать из массива
    func configure(image: UIImage) {
        photoImageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeCounterView.backgroundColor = .clear

    }
}


