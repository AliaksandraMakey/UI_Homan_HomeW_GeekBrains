//
//  NewsTableViewCell.swift
//  UI_Homan_Homework
//
//  Created by aaa on 09.06.22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
  
    @IBOutlet weak var oneNameLabel: UILabel!
    @IBOutlet weak var avatarImageSubview: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var oneNewsPhotoSubview: UIView!
    @IBOutlet weak var twoNewsPhotoSubview: UIView!
    @IBOutlet weak var oneNewsPhoto: UIImageView!
    @IBOutlet weak var twoNewsPhoto: UIImageView!
    @IBOutlet weak var commentView: UIView!
    
    override func prepareForReuse() {
        avatarImageView.image = nil
        oneNameLabel.text = nil
        avatarImageSubview = nil
        oneNewsPhoto.image = nil
        twoNewsPhoto.image = nil
        commentView = nil
    }
    
    func configure(news: News) {
        avatarImageView.image = news.avatarPhoto
        oneNameLabel.text = news.firstName + space + news.surName
        oneNewsPhoto.image = news.onePhoto
        twoNewsPhoto.image = news.twoPhoto
        
    }
 
    override func awakeFromNib() {
        super.awakeFromNib()

        /// тень для avatarImage
        avatarImageSubview.layer.shadowColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        avatarImageSubview.layer.shadowOffset = CGSize(width: 2, height: 2)
        avatarImageSubview.layer.shadowRadius = 5
        avatarImageSubview.layer.shadowOpacity = 1
        /// скругление фото avatarImageView
        avatarImageView.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        /// скругление фото avatarImageSubview
        avatarImageSubview.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        ///рамка для фото на avatarImageSubview
        avatarImageSubview.layer.borderWidth = 1
        avatarImageSubview.layer.borderColor = UIColor.black.cgColor
        ///рамка для фото на oneNewsPhotoSubview и twoNewsPhotoSubview
        oneNewsPhotoSubview.layer.borderWidth = 1
        oneNewsPhotoSubview.layer.borderColor = UIColor.black.cgColor
        twoNewsPhotoSubview.layer.borderWidth = 1
        twoNewsPhotoSubview.layer.borderColor = UIColor.black.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
