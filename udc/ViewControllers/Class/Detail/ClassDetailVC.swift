//
//  ClassDetailVC.swift
//  udc
//
//  Created by 도로맥 on 2021/08/16.
//

import Foundation
import UIKit

class ClassDetailVC : EXViewController {
    
    var classId : Int = 0
    var danceClass : DanceClass?{
        didSet{
            guard let danceClass = danceClass else { return }
            debugE("MAIN IMAGE VIEW 가즈아")
            debugE(danceClass.mainImgUrl)
            mainImageView.imageUrl = URL(string: danceClass.mainImgUrl)
        
          }
    }
    
    @objc var backArrowTapHandler: (() -> Void)?
    
    private lazy var mainImageView : EXImageView = {
        let v = EXImageView()
        v.contentMode = .center
        v.layer.cornerRadius = CGFloat(15)
        v.layer.masksToBounds = true

        return v
    }()
    
    private lazy var backArrowImage : UIImageView = {
        
        let v = UIImageView(named: "backarrow")
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: 24).isActive = true
        v.heightAnchor.constraint(equalToConstant: 24).isActive = true
        v.contentMode = .scaleAspectFit
        v.image = v.image!.withRenderingMode(.alwaysTemplate)
        v.tintColor = .black
        v.addGestureRecognizer(self.tapBackArrowGesture)
        
        return v
        
    }()
    
    private lazy var tapBackArrowGesture: UITapGestureRecognizer = {
        let t = UITapGestureRecognizer()
        t.addTarget(self, action: #selector(backArrowTapped(_ :)))
        return t
    }()
    
    @objc func backArrowTapped(_ sender : UITapGestureRecognizer){
        backArrowTapHandler?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backArrowTapHandler = { [unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
        
        configureTPNavigationBar()
        
        view.backgroundColor = .white
        initView()
        fetchClass()
    }
    
    private func initView() {
        
        let views = ["mainImageView": mainImageView , "backArrowImage" : backArrowImage ]
        
        view.addSubviews(mainImageView, backArrowImage)
        
        view.addConstraints("H:|[mainImageView]|", views: views)
        view.addConstraints("H:|[backArrowImage]", views: views)
        view.addConstraints("V:|[mainImageView]", views : views)
    }
    
    
    func fetchClass(forRefresh refresh: Bool = false) {

        DanceClass.fetchClass(classId: classId).done{[unowned self] danceClass in
            self.danceClass = danceClass
        }.catch{e in
            debugE(e)
        }
    }
}
