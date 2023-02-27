
import UIKit

class GalleryCollectionCell: UICollectionViewCell {
    //MARK: IBOutlet
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var likeCounter: UILabel!
    @IBOutlet weak var likeCounterView: UIView!
    
    static let identifier = "GalleryCollectionCell"
    /// prepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }
    /// pressHeartButton
    @IBAction func pressHeartButton(_ sender: Any) {
        guard let button = sender as? UIButton else {return}
        likeTapButton(button: button, counter: likeCounter, counterView: likeCounterView)
    }
    /// configure
    func configure(image: UIImage) {
        photoImageView.image = image
    }
    /// awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        likeCounterView.backgroundColor = .clear
    }
}


