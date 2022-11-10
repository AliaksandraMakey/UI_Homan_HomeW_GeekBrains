//
//  PhotoNewsCellXib.swift
//  UI_Homan_Homework
//
//  Created by aaa on 30.10.22.
//

import UIKit

@IBDesignable class PhotoNewsCellXib: UIView {

        private var view: UIView?
            
    @IBOutlet weak var oneImageNewsCell: UIImageView!
    @IBOutlet weak var twoImageNewsCell: UIImageView!
    
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
                let nib = UINib(nibName: "PhotoNewsCellXib", bundle: bundle)
                guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return UIView()}
                return view
            }
            
            private func setup() {
                view = loadFromNib()
                guard let view = view else {return print("ErrorPhotoNewsCellXib")}
                view.frame = bounds
                view.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
//                view.layer.cornerRadius = 8
//                view.layer.opacity = 1
                addSubview(view)
            }

    }

