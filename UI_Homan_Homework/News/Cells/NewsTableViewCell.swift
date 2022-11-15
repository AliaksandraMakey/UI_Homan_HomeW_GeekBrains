//
//  NewsTableViewCell.swift
//  UI_Homan_Homework
//
//  Created by aaa on 09.06.22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
  
    
    @IBOutlet weak var avatarImageSubview: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
  
    @IBOutlet weak var newsView: UIView! 
    @IBOutlet weak var commentView: UIView!
    
    override func prepareForReuse() {
        avatarImageView.image = nil
        avatarImageSubview = nil
        commentView = nil
        newsView = nil
    }
    
    func configure(news: News) {
        avatarImageView.image = news.avatarPhoto
    }
 
    override func awakeFromNib() {
        super.awakeFromNib()

        avatarImageSubview.layer.shadowColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        avatarImageSubview.layer.shadowOffset = CGSize(width: 2, height: 2)
        avatarImageSubview.layer.shadowRadius = 5
        avatarImageSubview.layer.shadowOpacity = 1
        avatarImageView.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        avatarImageSubview.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        avatarImageSubview.layer.borderWidth = 1
        avatarImageSubview.layer.borderColor = UIColor.black.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
