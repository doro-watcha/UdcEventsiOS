//
//  MapVC.swift
//  udc
//
//  Created by 도로맥 on 2021/05/26.
//

import Foundation
import UIKit


class MapVC : EXViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white

        configureTPNavigationBar()
        
        debugE("MapVC")
    }
    
}
