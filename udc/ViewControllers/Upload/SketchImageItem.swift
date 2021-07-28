//
//  SketchImage.swift
//  udc
//
//  Created by 도로맥 on 2021/07/28.
//

import Foundation
import UIKit

class SketchImageItem : EXCollectionViewCell {
    
    
    var image : UIImage? {
        didSet{
            guard let image = image else { return }
            sketchImageView.image = image
          }
    }

    private lazy var sketchImageView : EXImageView = {
        let v = EXImageView()
        v.contentMode = .scaleAspectFill
        v.layer.cornerRadius = CGFloat(4)
        v.layer.masksToBounds = true
        ///v.contentMode = .scaleAspectFill

        return v
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sketchImageView.image = nil
    }
    
    override func setup() {
        super.setup()
        
        debugE("GOOD!")
    
        contentView.addSubview(sketchImageView)
        contentView.backgroundColor = .clear

        let views = ["sketchImageView" : sketchImageView ]
        
        contentView.addConstraints("H:|-5-[sketchImageView]-5-|", views: views)
        contentView.addConstraints("V:|[sketchImageView]|", views : views )

    
    }
}
