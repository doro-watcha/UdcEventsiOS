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
import PromiseKit


protocol ScrollViewRenderer {
    
    var isScrollEnabled: Bool { get set }
    var contentScrollView: UIScrollView { get }
    
    func scrollsToTop()
    
}

class HomeVC : EXViewController {
    

    private var mainEventVC = MainEventVC()
    
    private var hotEventVC = EventListVC()
    
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        configureTPNavigationBar()
        
        initProvider()

        debugE("HOME VC")

        view.backgroundColor = .blue
        initLayout()
        setupView()
        

    }
    
    
    private func initProvider() {
        mainEventVC.dataProvider = MainEventProvider.newInstance()
        
    }
    
    private func initLayout() {
    
    
    }
    
    private func setupView(){
    
        addChild(mainEventVC)
        mainEventVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainEventVC.view)
        mainEventVC.didMove(toParent: self)
        
        let views = ["childView": mainEventVC.view!]
        view.addConstraints("H:|[childView]|", views: views)
        mainEventVC.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainEventVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
}
