//
//  CommonTextField.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation
import UIKit

class CommonTextField : EXTextField{
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 8.0
    @IBInspectable var rightInset: CGFloat = 8.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.textGray2.cgColor
        layer.cornerRadius = 4
        textColor = .black
        insetVertical = 8
        insetHorizontal = 8
        autocapitalizationType = .none
        autocorrectionType = .no
        
    }
}
