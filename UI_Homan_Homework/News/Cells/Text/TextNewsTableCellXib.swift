

import UIKit

class TextNewsTableCellXib: UITableViewCell {
    
    @IBOutlet weak var avatarPhotoSubview: UIView!
    @IBOutlet weak var avatarPhoto: UIImageView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var nameUserOrGroup: UILabel?
    
    @IBOutlet weak var postText: UITextView!
    
    static let identifier = "TextNewsTableCellXib"
    
    static func nib() -> UINib {
        return UINib(nibName: "TextNewsTableCellXib", bundle: nil)
    }

    func configure(news: NewsPost) {
        avatarPhoto.image = news.avatarImage
        postText?.text = news.textPost
        nameUserOrGroup?.text = news.namePersonOrGroupId
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cornerUIView(photo: avatarPhoto, photoSubview: avatarPhotoSubview)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func pressAvatarButton(_ sender: Any) {
        avatarViewAnimate(avatarImageView: avatarPhoto)
    }
}
