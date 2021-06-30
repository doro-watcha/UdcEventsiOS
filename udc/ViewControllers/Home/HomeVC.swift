//
//  HomeVC.swift
//  udc
//
//  Created by 도로맥 on 2021/05/26.
//

import Foundation
import MaterialComponents.MaterialBottomSheet
import MaterialComponents.MDCFloatingButton
import RxSwift
import UIKit

class HomeVC : EXViewController {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        configureTPNavigationBar()


        view.backgroundColor = .blue
        debugE("HOME")
        initLayout()
    }
    
    private func initLayout() {
    
    
    }
    
}
