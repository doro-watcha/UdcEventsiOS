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
    
    private lazy var appNameLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .bold13
        v.textColor = .white
        return v
    }()
    
    
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        configureTPNavigationBar()
        
        initProvider()

        debugE("HOME VC")

        view.backgroundColor = .blue
        initView()
        initLayout()
        setupView()
        

    }
    
    private func initView() {
        
        appNameLabel.text = "UDC Events"
    }
    
    private func initProvider() {
        mainEventVC.dataProvider = MainEventProvider.newInstance()
        
    }
    
    private func initLayout() {
    
    
    }
    
    private func setupView(){
    
        addChild(mainEventVC)
        mainEventVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubviews(mainEventVC.view, appNameLabel)
        mainEventVC.didMove(toParent: self)
        
        let views = ["mainEventView": mainEventVC.view!, "appNameLabel" : appNameLabel]
        
        view.addConstraints("H:|[mainEventView]|", views: views)
        
        appNameLabel.activateCenterXConstraint(to: view)
        mainEventVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16).isActive = true
        appNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16).isActive = true
        
        mainEventVC.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainEventVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
}
