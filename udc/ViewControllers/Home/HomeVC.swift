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
    private var newEventVC = EventListVC()
    
    private let scrollView = UIScrollView()
    
    var uploadTapHandler: (() -> Void)?
    
    
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
        debugE(self.navigationController)

        view.backgroundColor = .black
        initView()
        initLayout()
        setupView()
        initTapHandler()
        

        


    }
    
    private func initTapHandler() {
        
        newEventLabel.isUserInteractionEnabled = true
        
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(uploadButtonTapped(_ :)))
        newEventLabel.addGestureRecognizer(guestureRecognizer)
        uploadTapHandler = { [unowned self] in
            debugE("presentUpload")
            debugE(self.navigationController)
            self.presentUpload()
        }
    }
    private func initView() {
        
        appNameLabel.text = "UDC Events"
        hotEventLabel.text = "Hot Events"
        newEventLabel.text = "New Events"
        

    }
    
    private func initProvider() {
        mainEventVC.dataProvider = MainEventProvider.newInstance()
        hotEventVC.dataProvider = HotEventProvider.newInstance()
        newEventVC.dataProvider = NewEventProvider.newInstance()
        hotEventVC.sort = "hot"
        newEventVC.sort = "new"
        
    }
    
    private func initLayout() {
    
    
    }
    
    private func setupView(){
        
        addChild(mainEventVC)
        addChild(hotEventVC)
        addChild(newEventVC)
        
        mainEventVC.view.translatesAutoresizingMaskIntoConstraints = false
        hotEventVC.view.translatesAutoresizingMaskIntoConstraints = false
        newEventVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        mainEventVC.didMove(toParent: self)
        hotEventVC.didMove(toParent: self)
        newEventVC.didMove(toParent: self)
        
        /// 스크롤 뷰
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.zOrder = -1
        
        /// 스크롤 뷰 안 Container
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(container)
    
        let views = [
            "scrollView" : scrollView,
            "container" : container,
            "mainEventView": mainEventVC.view!,
            "appNameLabel" : appNameLabel,
            "newEventLabel" : newEventLabel,
            "hotEventLabel" : hotEventLabel,
            "hotEventView" : hotEventVC.view!,
            "newEventView" : newEventVC.view!
        ]

        view.addConstraints("|[scrollView]|", views : views)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
 
        
        scrollView.addConstraints("|[container]|", views: views)
        scrollView.addConstraints("V:|[container]|", views: views)
        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        container.heightAnchor.constraint(equalToConstant: 2000).isActive = true
        
        container.addSubview(appNameLabel)
        container.addSubview(newEventLabel)
        container.addSubview(hotEventLabel)
        container.addSubview(hotEventVC.view)
        container.addSubview(newEventVC.view)
        container.addSubview(mainEventVC.view )
    
        
        container.addConstraints("H:|[mainEventView]|", views: views)
        container.addConstraints("H:|[newEventView]|", views : views)
        container.addConstraints("H:|[hotEventView]|", views : views)
        container.addConstraints("V:|-0@250-[mainEventView]-16-[newEventLabel]-16-[newEventView]-16-[hotEventLabel]-16-[hotEventView]-|", views: views)
        
        
        appNameLabel.activateCenterXConstraint(to: container)
        appNameLabel.topAnchor.constraint(equalTo: container.topAnchor,constant: 16).isActive = true
        appNameLabel.zOrder = 1
    
        mainEventVC.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        mainEventVC.view.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        
        newEventLabel.activateCenterXConstraint(to: container)
        hotEventLabel.activateCenterXConstraint(to: container)
        
        
    }
    
    @objc func uploadButtonTapped(_ sender : Any){
        debugE("uploadButtonTapped")
        uploadTapHandler?()
    }
    
    
}


