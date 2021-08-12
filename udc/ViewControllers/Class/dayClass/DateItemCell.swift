//
//  DateItemCell.swift
//  udc
//
//  Created by 도로맥 on 2021/08/12.
//

import Foundation
import UIKit

class DateItemCell : EXCollectionViewCell {
    
    
    var classDate : ClassDate?{
        didSet{
            guard let date = classDate else { return }
            dayLabel.text = String(date.day)
            dateLabel.text = date.date
            
          }
    }
    
    
    private lazy var dayLabel : UILabel = {
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
    
    
    override func setup() {
        
        super.setup()
        
    
        contentView.addSubviews(dayLabel, dateLabel)


        let views = ["dayLabel" :dayLabel,"dateLabel" : dateLabel]

 
        contentView.addConstraints("V:|[dayLabel]-15-[dateLabel]|",views: views)
        
        dayLabel.activateCenterXConstraint(to: self)
        dateLabel.activateCenterXConstraint(to: self)
        
    }
}
    

