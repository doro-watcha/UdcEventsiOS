//
//  ErrorLabel.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation
import UIKit

/**
This subclass of UILabel is used below the textField for showing error message like invalid input
*/
class ErrorLabel: UILabel{
    required init?(coder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup(){
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        textColor = .pointPink
        font = .regular12
    }
}
