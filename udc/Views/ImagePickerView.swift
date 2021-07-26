//
//  ImagePickerView.swift
//  udc
//
//  Created by 도로맥 on 2021/07/26.
//

import Foundation
import UIKit

class ImagePickerView : UIView {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        backgroundColor = .boxGray
        layer.borderColor = UIColor.textFieldBorder.cgColor
        layer.cornerRadius = 4
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false

        imageView = UIImageView(named: "camera")
        //imageView.translatesAutoresizingMaskIntoConstraints = false

//        imageView.backgroundColor = .bgBlack
//        imageView.layer.borderColor = UIColor.white.cgColor
//        imageView.layer.borderWidth = 2

        addSubview(imageView)
        
        imageView.activateCenterConstraints(to: self)

        //let views = ["imageView": imageView!]
        //addConstraints("|[imageView]|", views: views)

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
