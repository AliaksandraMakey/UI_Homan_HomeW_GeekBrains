
import UIKit

//MARK: BigPhotosController
class BigPhotosViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var galleryView: BigPhotoViewXib!
        public var photoAlbum: [UIImage] = []
        public var selectedPhotoIndex: Int = 0
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

