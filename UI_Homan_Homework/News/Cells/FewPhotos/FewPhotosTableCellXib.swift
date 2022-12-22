//
//  FewPhotosTableCellXib.swift
//  UI_Homan_Homework
//
//  Created by aaa on 14.11.22.
//

import UIKit

class FewPhotosTableCellXib: UITableViewCell {
    
    @IBOutlet weak var photoTitleSubview: UIView!
    @IBOutlet weak var photoTitle: UIImageView!
    @IBOutlet weak var commentView: LikeAndCommentView!
    @IBOutlet weak var nameUserOrGroup: UILabel!
    @IBOutlet weak var photoInPostOne: UIImageView!
    @IBOutlet weak var photoInPostTwo: UIImageView!
    @IBOutlet weak var photoInPostThree: UIImageView!
    @IBOutlet weak var photoInPostFour: UIImageView!
    @IBOutlet weak var photoInPostFive: UIImageView!
    @IBOutlet weak var photoInPostSix: UIImageView!
    
    override func prepareForReuse() {
        photoTitle.image = nil
        photoTitleSubview = nil
        commentView = nil
        nameUserOrGroup = nil
        photoInPostOne.image = nil
        photoInPostTwo = nil
        photoInPostThree = nil
        photoInPostFour = nil
        photoInPostFive = nil
        photoInPostSix = nil
    }
    

    
    
    func configure(news: NewsPost) {
        nameUserOrGroup.text = news.namePersonOrGroupId
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cornerUIView(photo: photoTitle, photoSubview: photoTitleSubview)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
