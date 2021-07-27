//
//  RoundButton.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation
import UIKit
import MaterialComponents



class RoundButton : MDCButton{
    
    enum HeightType : CGFloat, CaseIterable{
        case Height54 = 54
        case Height36 = 36
        case Height24 = 24
    }
    
    private var height : HeightType
    var onClick : (() -> Void)?
    
    var text : String{
        get{return self.currentTitle ?? ""}
        set{self.setTitle(newValue, for: .normal)}
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    init(heightType : HeightType) {
        self.height = heightType
        super.init(frame: .zero)
        setup()
    }
    
    private func setup(){
        self.backgroundColor = .theme
        self.translatesAutoresizingMaskIntoConstraints  = false
        self.isUppercaseTitle = false
        
        //self.layer.cornerRadius = CGFloat(height.rawValue/2)
        
        self.heightAnchor.constraint(equalToConstant: height.rawValue).isActive = true
        self.widthAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
    
        addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        switch height{
            case .Height24:
                setTitleFont(.bold10, for: .normal)
            case .Height36:
                setTitleFont(.bold16, for: .normal)
            case .Height54:
                setTitleFont(.bold16, for: .normal)
        }
    
    }
    
    @objc private func tapped(){
        onClick?()
    }
    
}
