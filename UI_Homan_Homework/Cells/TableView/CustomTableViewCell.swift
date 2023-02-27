
import UIKit

class CustomTableViewCell: UITableViewCell {
    //MARK: IBOutlet
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avatarImageSubview: UIView!
    @IBOutlet weak var oneNameLabel: UILabel!
    @IBOutlet weak var twoNameLabel: UILabel!
        
    static let identifier = "CustomTableViewCell"
    /// nib
    static func nib() -> UINib {
        return UINib(nibName: "CustomTableViewCell", bundle: nil)
    }
    /// prepareForReuse
    override func prepareForReuse() {
        avatarImageView.image = nil
        oneNameLabel.text = nil
        twoNameLabel.text = nil
    }
    /// configure friend
    func configure(friend: Friend) {
        avatarImageView.image = friend.avatarPhoto
        oneNameLabel.text = friend.firstName + " " + friend.surName
        twoNameLabel.text = friend.birthDayDate
    }
    /// configure group
    func configure(group: Group) {
        avatarImageView.image = group.avatarPhoto
        oneNameLabel.text = group.titleGroup
    }
    /// awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        cornerUIView(photo: avatarImageView, photoSubview: avatarImageSubview)
    }
    /// setSelected
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    /// pressAvatarButton
    @IBAction func pressAvatarButton(_ sender: Any) {
        avatarViewAnimate(avatarImageView: avatarImageView)
    }
}

