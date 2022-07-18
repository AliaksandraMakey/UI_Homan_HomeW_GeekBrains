//
//  CustomTableViewCell.swift
//  UI_Homan_Homework
//
//  Created by aaa on 25.05.22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avatarImageSubview: UIView!
    @IBOutlet weak var oneNameLabel: UILabel!
    @IBOutlet weak var twoNameLabel: UILabel!

    var completion: ( () -> Void)?
    
    // передаем вышесвязанным параметрам значение nil для исключения проблем с дальнейшим присвоением новых значений
    override func prepareForReuse() {
        avatarImageView.image = nil
        oneNameLabel.text = nil
        twoNameLabel.text = nil
    }
    
    // создаем функцию для настройки новых значений  из структуры Friend
    func configure(friend: Friend, completion: ( () -> Void)? ) {
        self.completion = completion
        avatarImageView.image = friend.avatarPhoto
        oneNameLabel.text = friend.firstName + space + friend.surName
        twoNameLabel.text = friend.visitDate
    }
    
    // аналогично для стурктуры Group
    func configure(group: Group) {
        avatarImageView.image = group.avatarPhoto
        oneNameLabel.text = group.titleGroup
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Добавим тень для avatarImage
        avatarImageSubview.layer.shadowColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        avatarImageSubview.layer.shadowOffset = CGSize(width: 2, height: 2)
        avatarImageSubview.layer.shadowRadius = 5
        avatarImageSubview.layer.shadowOpacity = 1
        // добавим скругление фото avatarImageView
        avatarImageView.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        // добавим скругление фото avatarImageSubview
        avatarImageSubview.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        // добавим рамку для фото на avatarImageSubview
        avatarImageSubview.layer.borderWidth = 1
        avatarImageSubview.layer.borderColor = UIColor.black.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func pressAvatarButton(_ sender: Any) {

//        let frame = avatarImageView.frame
        
        ///время перехода UIView.animate(withDuration: 0.5)
        UIView.animate(withDuration: 0.05) { [weak self] in
            guard let self = self else {return}
            
            self.avatarImageView.frame = CGRect (x: self.avatarImageView.frame.origin.x + scale / 2, y: self.avatarImageView.frame.origin.y + scale / 2, width: self.avatarImageView.frame.width - scale, height: self.avatarImageView.frame.height - scale)
        } completion: { isSuccessfully in
            UIView.animate(withDuration: 2,
                           delay: 0,
                           usingSpringWithDamping: 0.3,
                           initialSpringVelocity: 7,
                           options: [ ]) { [weak self] in
                
                
                guard let self = self else {return}
                
                self.avatarImageView.frame = CGRect (x: self.avatarImageView.frame.origin.x - scale / 2, y: self.avatarImageView.frame.origin.y - scale / 2, width: self.avatarImageView.frame.width + scale, height: self.avatarImageView.frame.height + scale)
            } completion: { isAllSuccessfully in
                if isAllSuccessfully {
                    self.completion?()
                }
                
            }

        }
    }
}
