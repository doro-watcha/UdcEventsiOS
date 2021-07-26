//
//  EXTextView.swift
//  udc
//
//  Created by 도로맥 on 2021/07/27.
//

import Foundation
import UIKit

class EXTextView : UITextView{
    
    required init?(coder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer : textContainer)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.keyboardAppearance = UIKeyboardAppearance.dark
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.tintColor = .black
    }
    
}
