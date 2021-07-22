//
//  MainClassItemCell.swift
//  udc
//
//  Created by 도로맥 on 2021/07/22.
//

import Foundation
import UIKit


final class MainClassItemCell: EXTableViewCell {
    
    private let itemView = DanceClassView()
    
    var danceClass: DanceClass? {
        didSet {
            itemView.danceClass = danceClass
        }
    }
    
    override func setup() {
        super.setup()
        
        contentView.addSubview(itemView)
        
        let views = ["itemView": itemView]
        contentView.addConstraints("H:|[itemView]|", views: views)
    }
}


final class DanceClassView: UIView {
    

    private let posterImageView = EXImageView()

    private let titleLabel = UILabel(text: "", font: .bold13, color: .white)
    private let artistLabel = UILabel(text: "", font: .regular12, color: .white)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .bgBlack
        
        addSubview(posterImageView)

        addSubview(titleLabel)
        addSubview(artistLabel)
 

        
        let views = ["posterImageView": posterImageView, "titleLabel": titleLabel, "artistLabel": artistLabel]
        
        addConstraints("H:|-24-[posterImageView(40)]-024-|", options: .alignAllCenterY, metrics: nil, views: views)

   
    }
    
    
    var danceClass: DanceClass? {
        didSet {
            guard let danceClass = danceClass else { return }
            

            posterImageView.imageUrl = URL(string : danceClass.posterImgUrl)

            titleLabel.text = danceClass.title
            artistLabel.text = danceClass.title

        }
    }

    
}
