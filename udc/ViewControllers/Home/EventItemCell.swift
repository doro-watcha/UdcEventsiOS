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
            titleLabel.text = "TEST LABEL"
            
          }
    }
    
    private lazy var posterImageView : EXImageView = {
        let v = EXImageView()
        v.layer.cornerRadius = CGFloat(15)
        v.layer.masksToBounds = true
        ///v.contentMode = .scaleAspectFill
        return v
    }()
    
    private lazy var titleLabel : UILabel = {
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

        contentView.addSubviews(posterImageView,titleLabel, dateLabel)

        contentView.backgroundColor = .white

        let views = ["posterImageView" :posterImageView ,"titleLabel" :titleLabel ,"dateLabel" :dateLabel]

        contentView.addConstraints("H:|-10-[posterImageView]-10-|", views: views)
        contentView.addConstraints("V:|[posterImageView]|", views : views )
        
        titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor).isActive = true

    
    }
}
