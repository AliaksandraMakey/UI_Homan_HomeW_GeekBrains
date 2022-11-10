//
//  Photo+TextNewsCellXib.swift
//  UI_Homan_Homework
//
//  Created by aaa on 30.10.22.
//

import UIKit

@IBDesignable class PhotoTextNewsCellXib: UIView {
    
    private var view: UIView?
        
    @IBOutlet weak var textViewPhotoTextNews: UITextView!
    @IBOutlet weak var imagePhotoTextNews: UIImageView!
    override init(frame: CGRect) {
            super .init(frame: frame)
            setup()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
                    setup()
        }
        
        private func loadFromNib() -> UIView {
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: "PhotoTextNewsCellXib", bundle: bundle)
            guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return UIView()}
            return view
        }
        
        private func setup() {
            view = loadFromNib()
            guard let view = view else {return print("Error PhotoTextNewsCellXib")}
            view.frame = bounds
            view.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
            addSubview(view)
        }
    }

