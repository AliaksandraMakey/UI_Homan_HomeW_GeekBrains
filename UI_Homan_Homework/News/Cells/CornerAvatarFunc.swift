

import UIKit

      public func cornerUIView(photo: UIImageView, photoSubview: UIView){
            photoSubview.layer.shadowColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            photoSubview.layer.shadowOffset = CGSize(width: 2, height: 2)
            photoSubview.layer.shadowRadius = 5
            photoSubview.layer.shadowOpacity = 1
            photo.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
            photoSubview.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
            photoSubview.layer.borderWidth = 1
            photoSubview.layer.borderColor = UIColor.black.cgColor
        }
