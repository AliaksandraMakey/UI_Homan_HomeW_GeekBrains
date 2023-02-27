

import UIKit


class OnePhotoTextNewsTableCellXib: UITableViewCell {
    
    @IBOutlet weak var avatarPhotoSubview: UIView!
    @IBOutlet weak var avatarPhoto: UIImageView!
    @IBOutlet weak var commentView: LikeAndCommentView!
    @IBOutlet weak var nameUserOrGroup: UILabel!
    @IBOutlet weak var photoInPostOne: UIImageView!
    @IBOutlet weak var postText: UITextView!
    
    static let identifier = "OnePhotoTextNewsTableCellXib"
    
    static func nib() -> UINib {
        return UINib(nibName: "OnePhotoTextNewsTableCellXib", bundle: nil)
    }
    func configure(news: NewsPost) {
        avatarPhoto.image = news.avatarImage
            postText?.text = news.textPost
        nameUserOrGroup?.text = news.namePersonOrGroupId
        photoInPostOne.image = news.photosImage.first as? UIImage
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
