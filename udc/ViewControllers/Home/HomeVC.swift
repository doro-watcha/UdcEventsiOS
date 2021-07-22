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
    

    private lazy var newEventLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .bold13
        v.textColor = .white
        
        return v
    }()
    
    private lazy var hotEventLabel : UILabel = {
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
        newEventLabel.text = "New Event"
        hotEventLabel.text = "Hot Event"
        
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
        
        let views = ["mainEventView": mainEventVC.view!, "appNameLabel" : appNameLabel, "newEventLabel" : newEventLabel, "hotEventLabel" : hotEventLabel]
        
        view.addConstraints("H:|[mainEventView]|", views: views)
        view.addConstraints("V:[mainEventView]", views: views)
        
        appNameLabel.activateCenterXConstraint(to: view)
        appNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16).isActive = true
    
        mainEventVC.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true

        mainEventVC.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainEventVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
}
