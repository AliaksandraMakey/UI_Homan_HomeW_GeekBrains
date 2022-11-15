

import UIKit

class OnePhotoTextNewsTableCellXib: UITableViewCell {
    
    @IBOutlet weak var photoTitleSubview: UIView!
    @IBOutlet weak var photoTitle: UIImageView!
    @IBOutlet weak var commentView: LikeAndCommentView!
    @IBOutlet weak var nameUserOrGroup: UILabel!
    @IBOutlet weak var photoInPostOne: UIImageView!
    @IBOutlet weak var postText: UITextView!
    
    override func prepareForReuse() {
        photoTitle.image = nil
        photoTitleSubview = nil
        commentView = nil
        nameUserOrGroup = nil
        photoInPostOne = nil
        postText = nil
    }
    
    func configure(news: News) {
        photoTitle.image = news.avatarPhoto
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cornerUIView(photo: photoTitle, photoSubview: photoTitleSubview)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
