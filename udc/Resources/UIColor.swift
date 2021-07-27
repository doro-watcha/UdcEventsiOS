//
//  UIColor.swift
//  udc
//
//  Created by 도로맥 on 2021/05/28.
//

import Foundation
import UIKit

extension UIColor {
    
    // 기본 컬러
    class var theme:  UIColor {return  #colorLiteral(red: 0.5294117647, green: 0.3450980392, blue: 0.9764705882, alpha: 1) }
    class var theme2: UIColor {return  #colorLiteral(red: 0.6705882353, green: 0.5098039216, blue: 0.9764705882, alpha: 1) }
    
    // 폰트 컬러
    class var textWhite: UIColor { return UIColor(rgb: 0xf9f9f9) }
    class var textGray:  UIColor { return UIColor(red: 153, green: 153, blue: 153) }
    class var textGray2 : UIColor { return UIColor(rgb: 0xbdbdbd)}
    
    class var boxGray : UIColor { return UIColor(rgb:0xCCCCCCCC)}
    
    // BG 컬러
    class var bgBlack:      UIColor {return #colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.1411764706, alpha: 1) }
    class var surfaceBlack: UIColor {return #colorLiteral(red: 0.06274509804, green: 0.06274509804, blue: 0.06274509804, alpha: 1) }
    class var bg1: UIColor { return UIColor(red: 233, green: 234, blue: 235) }
    class var bg2: UIColor { return UIColor(rgb: 0x242424) }
    
    // 포인트 컬러
    class var pointPink: UIColor { return #colorLiteral(red: 1, green: 0.4648788571, blue: 0.6459146738, alpha: 1)} // alert red
    class var pointRed:  UIColor { return UIColor(rgb: 0xff2467) } // like red
    class var pointGreen:UIColor { return UIColor(rgb: 0x3fba81) } // success green
    class var pointBlue: UIColor { return UIColor(rgb: 0x4595e5) } // button blue
    
    
    // 이미지 테두리 컬러
    class var imageBorder: UIColor { return UIColor(rgb: 0xcccccc) }
    
    // 대화상자 컬러
    class var textFieldBorder: UIColor { return #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1) }
    class var dialogCancelGray: UIColor { return #colorLiteral(red: 0.4872976542, green: 0.4873096347, blue: 0.4873031378, alpha: 1) }
    
    // SNS Login
    class var naverGreen : UIColor { return UIColor ( rgb : 0x03C75A)}
    class var kakaoYellow : UIColor { return UIColor ( red : 251 , green : 227 , blue:77)}
    

}
