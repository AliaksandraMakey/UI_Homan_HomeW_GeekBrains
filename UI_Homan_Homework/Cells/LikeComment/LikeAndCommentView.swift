
import UIKit

@IBDesignable class LikeAndCommentView: UIView {
    //MARK: IBOutlet
    @IBOutlet weak var watchedCount: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var watchedCounterLabel: UILabel!
    @IBOutlet weak var likeCounter: UILabel!
    @IBOutlet weak var likeCounterView: UIView!
    
    private var view: UIView?
    /// override init frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    /// required init coder
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    /// loadFromNib
    private func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LikeAndCommentView", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return UIView()}
        return view
    }
    /// setup
    private func setup() {
        view = loadFromNib()
        guard let view = view else {return}
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    //MARK: IBAction
    @IBAction func pressHeartButton(_ sender: Any) {
        guard let button = sender as? UIButton else {return}
        likeTapButton(button: button, counter: likeCounter, counterView: likeCounterView)
    }
}
