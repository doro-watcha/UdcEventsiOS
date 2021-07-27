//
//  TypePickVC.swift
//  udc
//
//  Created by 도로맥 on 2021/07/27.
//

import Foundation
import UIKit

class TypePickVC : EXViewController {
    
    private lazy var battleLabel : UILabel = {
        let v = UILabel()
        
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "배틀"
        v.font = .bold25
        
        return v
    }()
    
    private lazy var performanceLabel : UILabel = {
        let v = UILabel()
        
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "퍼포먼스"
        v.font = .bold25
        
        return v
    }()
    
    private lazy var workshopLabel : UILabel = {
        let v = UILabel()
        
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "워크샵"
        v.font = .bold25
        
        return v
    }()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        initView()
        
        
    }
    
    private func initView() {
        
        view.addSubviews(battleLabel, performanceLabel, workshopLabel)
        
        let views = [
            "battleLabel" : battleLabel,
            "performanceLabel" : performanceLabel,
            "workshopLabel" : workshopLabel
        ]
        
        view.addConstraints("V:|-25-[battleLabel]-25-[performanceLabel]-25-[workshopLabel]", views : views)
        
        battleLabel.activateCenterXConstraint(to: view)
        performanceLabel.activateCenterXConstraint(to: view)
        workshopLabel.activateCenterXConstraint(to: view)
        
    }
    
}
