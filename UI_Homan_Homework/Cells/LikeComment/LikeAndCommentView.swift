//
//  LikeAndCommentView.swift
//  UI_Homan_Homework
//
//  Created by aaa on 10.06.22.
//

import UIKit

@IBDesignable class LikeAndCommentView: UIView {
    @IBOutlet weak var watchedCount: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var watchedCounterLabel: UILabel!
    @IBOutlet weak var likeCounterLabel: UILabel!
    
    
    // создаем view
    private var view: UIView?
    // переопределяем инициализатор. будет использоватьбся при работе с данным view в коде
    override init(frame: CGRect) {
        super.init(frame: frame)
                setup()
    }
    // этот инициализатор используется сторибордом
    required init?(coder: NSCoder) {
        super.init(coder: coder)
                setup()
    }
    
    private func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LikeAndCommentView", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return UIView()}
        return view
    }

    private func setup() {
        view = loadFromNib()
        guard let view = view else {return}
        view.frame = bounds
        // autoresizingMask используем для того, чтобы созданная view меняла размер в зависимости от разрешения сцены
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    @IBAction func pressHeartButton(_ sender: Any) {guard let button = sender as? UIButton else {return}
        if likeEnable {
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            counter -= 1
            likeCounterLabel.text = String(counter)
        } else {
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            counter += 1
            likeCounterLabel.text = String(counter)
        }
        likeEnable = !likeEnable
    }
    
}
