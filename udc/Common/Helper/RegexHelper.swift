//
//  RegexHelper.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation
class RegexHelper{
    static let emailRegex = "^\\w+([.-]?\\w+)*@\\w+([.-]?\\w+)*(\\.\\w{2,3})+$"
    static let passwordRegex = "^(?=.*[0-9])(?=.*[!@#$%^&*])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%^&*]{8,20}$"
}

extension String{
    
    var isValidEmail: Bool{
        return self.range(of: RegexHelper.emailRegex, options: .regularExpression) != nil
    }
    
    var isValidPassword: Bool{
        return self.range(of: RegexHelper.passwordRegex, options: .regularExpression) != nil
    }
    
}
