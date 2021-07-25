//
//  EventItemCell.swift
//  udc
//
//  Created by 도로맥 on 2021/07/21.
//

import Foundation
import UIKit


class EventItemCell : EXCollectionViewCell{
    
    var event : Event?{
        didSet{
            guard let event = event else { return }
            posterImageView.imageUrl = URL(string: event.posterImgUrl)
        
          }
    }
    
    private lazy var posterImageView : EXImageView = {
        let v = EXImageView()
        v.layer.cornerRadius = CGFloat(10)
        v.layer.masksToBounds = true
        ///v.contentMode = .scaleAspectFill
        return v
    }()
    
    private var titleLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .bold13
        v.textColor = .white
        v.text = "TEST LABEL"
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

        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)

        contentView.backgroundColor = .black

        let views = ["posterImageView" :posterImageView ,"titleLabel" :titleLabel ,"dateLabel" :dateLabel]
        
        
      
        titleLabel.activateCenterXConstraint(to: contentView)
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        contentView.addConstraints("H:|-10-[posterImageView]-10-|", views: views)
  //      contentView.addConstraints("H:|[titleLabel]|", views: views)
        contentView.addConstraints("V:|-10-[posterImageView]-20-|", views : views )

    
    }
}
