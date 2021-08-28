//
//  MainEventItemCell.swift
//  udc
//
//  Created by 도로맥 on 2021/07/21.
//

import Foundation
import UIKit


class MainEventItemCell : EXCollectionViewCell{
    
    var event : Event?{
        didSet{
            guard let event = event else { return }
            posterImageView.imageUrl = URL(string: event.posterImgUrl)
            titleLabel.text = event.name
            subTitleLabel.text = event.subtitle
            dateLabel.text = event.createdAt
          }
    }
    

    private lazy var posterImageView : EXImageView = {
        let v = EXImageView()
        v.layer.cornerRadius = CGFloat(15)
        v.layer.masksToBounds = true
        v.backgroundColor = .blue 

        return v
    }()
    
    private lazy var titleLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .bold13
        v.textColor = .white
        return v
    }()
    
    private lazy var subTitleLabel : UILabel = {
        
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .bold13
        v.textColor = .white
        return v
    }()
    
    private lazy var dateLabel : UILabel = {
        
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .bold13
        v.textColor = .white
        return v
        
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.imageUrl = nil
    }
    
    override func setup() {
        
        
        super.setup()
        
        debugE("MainEvent까쯔아")
    
        contentView.addSubviews(posterImageView, titleLabel, subTitleLabel, dateLabel)


        let views = ["posterImageView" :posterImageView, "titleLabel" :titleLabel ,"subTitleLabel" : subTitleLabel,
                     "dateLabel" : dateLabel ]

        contentView.addConstraints("V:|-50-[posterImageView]-50-|",views: views)
        contentView.addConstraints("H:|-50-[posterImageView]-50-|",views: views)
        
        titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor).isActive = true
        
    }
}


