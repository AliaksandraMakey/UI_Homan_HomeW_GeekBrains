

import UIKit

func avatarViewAnimate(avatarImageView view: UIImageView) {
    let scale = CGFloat(30)
    UIImageView.animate(withDuration: 0.05) {
        view.frame = CGRect (x: view.frame.origin.x + scale / 2, y: view.frame.origin.y + scale / 2, width: view.frame.width - scale, height: view.frame.height - scale)
    } completion: {
        isSuccessfully in
        UIImageView.animate(withDuration: 2,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 7,
                       options: [ ]) {
            view.frame = CGRect (x: view.frame.origin.x - scale / 2, y: view.frame.origin.y - scale / 2, width: view.frame.width + scale, height: view.frame.height + scale)
        }
    }
}

