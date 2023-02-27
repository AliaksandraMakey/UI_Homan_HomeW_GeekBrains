
import UIKit

var likeEnable = false

func likeTapButton(button: UIButton, counter: UILabel, counterView: UIView) {
    var count = 0
    if likeEnable {
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        count -= 1
        counter.text = String(count)
    } else {
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        UIView.transition(with: counterView, duration: 0.5,
                          options: .transitionFlipFromLeft,
                          animations: { counterView.frame},
                          completion: nil)
    }
    count += 1
    counter.text = String(count)
    likeEnable = !likeEnable
}
