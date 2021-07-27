//
//  EventDetailVC.swift
//  udc
//
//  Created by 도로맥 on 2021/07/25.
//

import Foundation
import UIKit

class EventDetailVC : UIViewController {
    
    var event : Event?{
        didSet{
            guard let event = event else { return }
            posterImageView.imageUrl = URL(string: event.posterImgUrl)
            backgroundImageView.imageUrl = URL(string: event.posterImgUrl)
        
          }
    }
    
    private lazy var backgroundImageView:EXImageView = {
        let v = EXImageView()
        v.contentMode = .center
        
        return v
    }()
    
    private lazy var posterImageView : EXImageView = {
        let v = EXImageView()
        v.contentMode = .center
        v.layer.cornerRadius = CGFloat(15)
        v.layer.masksToBounds = true

        return v
    }()
    
    override func viewDidLoad() {

        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        view.backgroundColor = .red
        initView()
    }
    
   
    
    private func initView() {

        let views = ["posterImageView": posterImageView, "backgroundImageView" : backgroundImageView]
        

        
        view.addSubviews(posterImageView, backgroundImageView)
        
        view.addConstraints("H:|[backgroundImageView]|", views: views)
        view.addConstraints("H:|-20-[posterImageView]", views : views)
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true 
        backgroundImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor).isActive = true
        posterImageView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor).isActive = true
        posterImageView.bringSubviewToFront(view)
        
        
    }
}


