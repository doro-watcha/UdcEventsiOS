//
//  GenreClassItem.swift
//  udc
//
//  Created by 도로맥 on 2021/08/12.
//

import Foundation
import UIKit


class GenreClassItemCell : EXCollectionViewCell {
    
    var danceClass : DanceClass?{
        didSet{
            guard let danceClass = danceClass else { return }
            posterImageView.imageUrl = URL(string: danceClass.artistProfileImgUrl ?? "")
          }
    }
    
    private lazy var posterImageView : EXImageView = {
        let v = EXImageView()

        return v
    }()
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.imageUrl = nil
    }
    
    override func setup() {
        
        super.setup()
        
        debugE("dkdh~~ 까쯔아")
    
        contentView.addSubviews(posterImageView)


        let views = ["posterImageView" :posterImageView]

        contentView.addConstraints("H:|[posterImageView]|",views: views)
        contentView.addConstraints("V:|[posterImageView]|",views: views)
        
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
    }
}
