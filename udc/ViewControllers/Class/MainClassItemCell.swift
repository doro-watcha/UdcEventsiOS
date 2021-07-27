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
            guard let danceClass = danceClass else { return }
            posterImageView.imageUrl = URL(string: danceClass.posterImgUrl)
          }
    }
    

    private lazy var posterImageView : EXImageView = {
        let v = EXImageView()
        v.contentMode = .center
        v.layer.cornerRadius = CGFloat(15)
        v.layer.masksToBounds = true

        return v
    }()
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.imageUrl = nil
    }
    
    override func setup() {
    
        contentView.addSubviews(posterImageView)


        let views = ["posterImageView" :posterImageView]

        contentView.addConstraints("V:|-50-[posterImageView]-50-|",views: views)
        contentView.addConstraints("H:|-50-[posterImageView]-50-|",views: views)
        
    }
}


