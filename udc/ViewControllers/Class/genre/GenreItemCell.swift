//
//  GenreItemCell.swift
//  udc
//
//  Created by 도로맥 on 2021/08/12.
//

import Foundation
import UIKit


class GenreItemCell : EXCollectionViewCell {
    
    
    var genre : Genre?{
        didSet{
            guard let genre = genre else { return }
            genreName.text = genre.name
          }
    }
    
    private lazy var genreName : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .bold13
        v.textColor = .black
        return v
    }()
    
    
    override func setup() {
        
        super.setup()
        
        contentView.addSubviews(genreName)


        let views = ["genreName" :genreName]

 
        contentView.addConstraints("V:|[genreName]|",views: views)
        
        genreName.activateCenterXConstraint(to: self)
    }
    
    
}
