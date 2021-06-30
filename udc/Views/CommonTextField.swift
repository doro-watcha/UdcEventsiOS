//
//  CommonTextField.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation
import UIKit

class CommonTextField : EXTextField{
    
    required init?(coder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .surfaceBlack
        layer.borderWidth = 1
        layer.borderColor = UIColor.textFieldBorder.cgColor
        layer.cornerRadius = 4
        textColor = .white
        font = .regular16
        insetVertical = 8
        insetHorizontal = 8
        autocapitalizationType = .none
        autocorrectionType = .no
        
    }
}
