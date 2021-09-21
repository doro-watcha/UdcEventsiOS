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
            posterImageView.imageUrl = URL(string: danceClass.artist.profileImgUrl)
          }
    }
    

    private lazy var posterImageView : EXImageView = {
        let v = EXImageView()
        v.contentMode = .scaleAspectFit

        return v
    }()
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.imageUrl = nil
    }
    
    override func setup() {
        
        super.setup()
        
    
        contentView.addSubviews(posterImageView)

        let views = ["posterImageView" :posterImageView]

        contentView.addConstraints("H:|[posterImageView]|",views: views)
        
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true 
        
    }
}


