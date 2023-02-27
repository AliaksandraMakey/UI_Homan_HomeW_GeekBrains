

import UIKit

class FewPhotosTableCellXib: UITableViewCell {
    
    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var avatarPhotoSubview: UIView!
    @IBOutlet weak var avatarPhoto: UIImageView!
    @IBOutlet weak var commentView: LikeAndCommentView!
    @IBOutlet weak var nameUserOrGroup: UILabel!
    @IBOutlet weak var photoInPostOne: UIImageView!
    @IBOutlet weak var photoInPostTwo: UIImageView!
    @IBOutlet weak var photoInPostThree: UIImageView!
    @IBOutlet weak var photoInPostFour: UIImageView!
    @IBOutlet weak var photoInPostFive: UIImageView!
    @IBOutlet weak var photoInPostSix: UIImageView!
    
    
    static let identifier = "FewPhotosTableCellXib"
    
    static func nib() -> UINib {
        return UINib(nibName: "FewPhotosTableCellXib", bundle: nil)
    }
    
    func configure(news: NewsPost) {
        avatarPhoto.image = news.avatarImage
        nameUserOrGroup?.text = news.namePersonOrGroupId
        postText?.text = news.textPost
        photoInPostOne.image = news.photosImage[0]
        photoInPostTwo.image = news.photosImage[1]
        photoInPostThree.image = news.photosImage[2]
//            photoInPostFour.image = news.photosImage[3]
//            photoInPostFive.image = news.photosImage[4]
//            photoInPostSix.image = news.photosImage[5]
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
