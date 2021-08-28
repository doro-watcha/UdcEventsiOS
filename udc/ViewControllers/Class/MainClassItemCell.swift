//
//  MainClassItemCell.swift
//  udc
//
//  Created by 도로맥 on 2021/07/22.
//

import Foundation
import UIKit



class MainClassItemCell : EXCollectionViewCell{
    
    var danceClass : DanceClass?{
        didSet{
            debugE("ASDASDASDASDASD")
            guard let danceClass = danceClass else { return }
            posterImageView.imageUrl = URL(string: danceClass.mainImgUrl)
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
        
        debugE("SETUP 까쯔아")
    
        contentView.addSubviews(posterImageView)


        let views = ["posterImageView" :posterImageView]

        contentView.addConstraints("H:|[posterImageView]|",views: views)
        contentView.addConstraints("V:|[posterImageView]|",views: views)
        
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
    }
}


