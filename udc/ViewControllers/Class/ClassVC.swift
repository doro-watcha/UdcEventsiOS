//
//  ClassVC.swift
//  udc
//
//  Created by 도로맥 on 2021/05/26.
//

import Foundation
import UIKit


final class ClassVC : EXViewController {
    
    
    private var mainClassVC = MainClassVC()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

      
        configureTPNavigationBar()
        
        self.view.backgroundColor = .red

        setupView()
    }
    
    private func setupView(){
    
        addChild(mainClassVC)
        mainClassVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubviews(mainClassVC.view)
        mainClassVC.didMove(toParent: self)
        
        let views = ["mainClassView": mainClassVC.view!]
        
        view.addConstraints("H:|[mainClassView]|", views: views)
        
        mainClassVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16).isActive = true
        
        mainClassVC.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainClassVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
}
