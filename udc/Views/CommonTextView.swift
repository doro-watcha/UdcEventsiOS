//
//  CommonTextView.swift
//  udc
//
//  Created by 도로맥 on 2021/07/27.
//

import Foundation
import UIKit


class CommonTextView : EXTextView{
    required init?(coder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame,textContainer : textContainer)
        
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.boxGray.cgColor
        layer.cornerRadius = 4
        contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textColor = .black
        font = .regular16
        autocapitalizationType = .none
        autocorrectionType = .no
    }
}
