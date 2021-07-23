//
//  EventVCCell.swift
//  udc
//
//  Created by 도로맥 on 2021/07/23.
//

import UIKit
import Kingfisher

final class EventCVCell: EXCollectionViewCell {
    
    // MARK: -View, Variables
    let posterImageView = EXImageView()

    
    // MARK: -Data
    var event: Event? {
        didSet {
            guard let event = event else { return }
            posterImageView.imageUrl = URL(string:event.posterImgUrl)
            
            
        }
    }
    
    func setLocalImage(with url: URL?){
        posterImageView.setLocalImageUrl(url: url)
    }
 

    
    override func setup() {
        super.setup()
        
        contentView.isUserInteractionEnabled = true

        
        posterImageView.contentMode = .scaleAspectFill
        contentView.addSubviews(posterImageView)

        
        let views = [
            "posterImageView": posterImageView
        ]
        contentView.addConstraints("H:|[posterImageView]|", views: views)
        contentView.addConstraints("V:|[posterImageView]|", views: views)
    
        
    }
    

    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.imageUrl = nil

    }
    
}

// MARK: -Action
extension EventCVCell{
    @objc private func onLongPress(_ recognizer: UILongPressGestureRecognizer){
        if recognizer.state == UILongPressGestureRecognizer.State.began{
            guard let event = self.event else { return }
          //  onLongPressed?(video)
        }
    }
    
}


