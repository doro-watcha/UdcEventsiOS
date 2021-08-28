//
//  ClassVC.swift
//  udc
//
//  Created by 도로맥 on 2021/05/26.
//

import Foundation
import UIKit


class ClassVC : EXViewController {
    
    
    private var mainClassVC = MainClassVC()
    private var dayClassVC = DayClassVC()
    private var genreClassVC = GenreListVC()
    
    private let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureTPNavigationBar()
        
        self.view.backgroundColor = .black

        initProvider()
        setupView()

    }
    
    private func initProvider() {
        mainClassVC.dataProvider = MainClassProvider.newInstance()
        genreClassVC.dataProvider = GenreNameProvider.newInstance()
    }
    
    
    private func setupView(){
        addChild(mainClassVC)
        addChild(dayClassVC)
        addChild(genreClassVC)
        mainClassVC.view.translatesAutoresizingMaskIntoConstraints = false
        dayClassVC.view.translatesAutoresizingMaskIntoConstraints = false
        genreClassVC.view.translatesAutoresizingMaskIntoConstraints = false

        mainClassVC.didMove(toParent: self)
        dayClassVC.didMove(toParent : self)
        genreClassVC.didMove(toParent: self)
   
        
        /// 스크롤 뷰
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.zOrder = -1
        scrollView.bounces = scrollView.contentOffset.y > 0
        /// 스크롤 뷰 안 Container
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(container)
    
        let views = [
            "scrollView" : scrollView,
            "container" : container,
            "mainClassView": mainClassVC.view!,
            "genreClassView" :genreClassVC.view!
        ]

        view.addConstraints("|[scrollView]|", views : views)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
 
        
        scrollView.addConstraints("|[container]|", views: views)
        scrollView.addConstraints("V:|[container]|", views: views)
        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        container.heightAnchor.constraint(equalToConstant: view.frame.height * 2).isActive = true
        
        container.addSubviews(mainClassVC.view, genreClassVC.view)

    
        container.addConstraints("H:|[mainClassView]|", views: views)
        container.addConstraints("H:|[genreClassView]|", views: views)
        container.addConstraints("V:[mainClassView]-[genreClassView]", views: views)
        
    
        mainClassVC.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        mainClassVC.view.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        
        genreClassVC.view.heightAnchor.constraint(equalToConstant:UIScreen.main.bounds.width).isActive = true
        genreClassVC.view.topAnchor.constraint(equalTo: mainClassVC.view.bottomAnchor).isActive = true


        
    }
}
