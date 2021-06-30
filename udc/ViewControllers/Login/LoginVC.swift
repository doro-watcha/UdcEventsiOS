//
//  LoginVC.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation
import UIKit

class LoginVC : EXViewController {
    
    var onTapLogin: (() -> Void)?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureTPNavigationBar()
        
        self.view.backgroundColor = .green
        
        debugE("Login VC")
    }
    
    
}
