

import UIKit

class TextNewsTableCellXib: UITableViewCell {
    
    
    
    @IBOutlet weak var photoTitleSubview: UIView!
    @IBOutlet weak var photoTitle: UIImageView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var nameUserOrGroup: UILabel?
    @IBOutlet weak var postText: UILabel?
    
    override func prepareForReuse() {
        photoTitle.image = nil
        photoTitleSubview = nil
        commentView = nil
        nameUserOrGroup = nil
        postText = nil
    }
    
    func configure(news: NewsPost) {
        if news.namePersonOrGroupId != nil && news.textPost != nil {
            postText?.text = news.textPost
            nameUserOrGroup?.text = news.namePersonOrGroupId
        } else {
            nameUserOrGroup?.text = " "
            postText?.text  = " "
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cornerUIView(photo: photoTitle, photoSubview: photoTitleSubview)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
