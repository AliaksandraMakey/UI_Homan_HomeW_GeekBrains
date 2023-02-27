
import UIKit

func userAvatarCustom(avatarPhoto: UIView, avatarSubview: UIView) {
   
    avatarPhoto.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
    avatarSubview.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
    avatarSubview.layer.shadowColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    avatarSubview.layer.shadowOffset = CGSize(width: 2, height: 2)
    avatarSubview.layer.shadowRadius = 5
    avatarSubview.layer.shadowOpacity = 1
    avatarSubview.layer.borderWidth = 1
    avatarSubview.layer.borderColor = UIColor.black.cgColor
}
