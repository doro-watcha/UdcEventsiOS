//
//  SettingVC.swift
//  udc
//
//  Created by 도로맥 on 2021/08/16.
//

import Foundation
import UIKit

class SettingVC : EXViewController {
    
    
    
    private lazy var logoutButton : RoundButton = {
        let v = RoundButton(heightType: .Height54)
        v.text = Str.common_logout
        v.backgroundColor = .black
        v.layer.cornerRadius = 10
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCustomNavigationBar()
        
        initView()
        
    }
    

    
}

extension SettingVC{
    private func initView(){
        
        view.backgroundColor = .white
        
        
        

        view.addSubview(logoutButton)
        
        let views = [ "logoutButton" : logoutButton]
      

        view.addConstraints("H:|-10-[logoutButton]-10-|",views : views)
        view.addConstraints("V:[logoutButton]-20-|", views: views)
        
        logoutButton.onClick = {[unowned self] in
            self.signOut()
        }
    }
    
    private func signOut() {
        AuthHelper.logout()
        self.dismiss(animated: true, completion: nil)
        debugE("dismiss 완료!")
    }
}
