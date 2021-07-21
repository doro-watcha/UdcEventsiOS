//
//  EventItemCell.swift
//  udc
//
//  Created by 도로맥 on 2021/07/21.
//

import Foundation
import UIKit


class EventItemcell : EXCollectionViewCell{
    
    var event : Event?{
        didSet{
            guard let event = event else { return }
            posterImageView.imageUrl = URL(string: event.posterImgUrl)
            titleLabel.text = event.name
            
          }
    }
    
    private lazy var posterImageView : EXImageView = {
        let v = EXImageView()
        v.contentMode = .scaleAspectFill
        return v
    }()
    
    private lazy var titleLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .bold13
        v.textColor = .white
        return v
    }()
    
    private lazy var artistLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .regular13
        v.textColor = .white
        return v
    }()
    
    private lazy var videoCountLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .bold13
        v.textColor = .white
        return v
    }()
    
    private lazy var videoIcon : UIImageView = {
        let v = UIImageView(named: "video")
        v.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(artistLabel)
        contentView.addSubview(videoCountLabel)
        contentView.addSubview(videoIcon)

        let views = ["posterImageView" :posterImageView ,"titleLabel" :titleLabel ,"artistLabel" :artistLabel ,"videoCountLabel" : videoCountLabel
            ,"videoIcon" : videoIcon]

        posterImageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        posterImageView.activateCenterYConstraint(to: contentView)

        titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor).isActive = true

        videoCountLabel.activateCenterYConstraint(to: contentView)
        videoIcon.activateCenterYConstraint(to: contentView)

        contentView.addConstraints("|-25-[posterImageView]-12-[titleLabel]-12-[videoCountLabel]-6-[videoIcon]-26-|", views: views)
        contentView.addConstraints("V:[titleLabel]-7-[artistLabel]",options: [.alignAllLeading], views: views)

    
    }
}
