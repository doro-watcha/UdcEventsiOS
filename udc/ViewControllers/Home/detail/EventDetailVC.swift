//
//  EventDetailVC.swift
//  udc
//
//  Created by 도로맥 on 2021/07/25.
//

import Foundation
import UIKit

class EventDetailVC : EXViewController {
    
    var event : Event?{
        didSet{
            guard let event = event else { return }
            posterImageView.imageUrl = URL(string: event.posterImgUrl)
        
          }
    }
    
    
    private lazy var posterImageView : EXImageView = {
        let v = EXImageView()
        v.contentMode = .center
        v.layer.cornerRadius = CGFloat(15)
        v.layer.masksToBounds = true

        return v
    }()
    
    override func viewDidLoad() {
        
        view.backgroundColor = .red
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false

    }
    
    private func initView() {
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)

        let navItem = UINavigationItem(title: "행사 등록하기")
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(done))
        navItem.rightBarButtonItem = doneItem

        navBar.setItems([navItem], animated: false)
        
        let views = ["posterImageView": posterImageView]
        


        view.addSubview(posterImageView)
        
        view.addConstraints("H:|[posterImageView]|", views: views)
        view.addConstraints("V:|-100-[posterImageView]|", views: views)
    }
    @objc func done() { // remove @objc for Swift 3

    }
}
