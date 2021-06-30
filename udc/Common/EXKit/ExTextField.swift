//
//  ExTextField.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation
import UIKit

class EXTextField : UITextField{
    
    @IBInspectable var insetHorizontal: CGFloat = 0
    @IBInspectable var insetVertical: CGFloat = 0

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.keyboardAppearance = UIKeyboardAppearance.dark
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetHorizontal, dy: insetVertical)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
}
