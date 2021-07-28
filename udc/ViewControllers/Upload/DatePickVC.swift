//
//  DatePickVC.swift
//  udc
//
//  Created by 도로맥 on 2021/07/27.
//

import Foundation
import UIKit

class DatePickVC : UIViewController {
    
    private lazy var pickDateLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .bold25
        v.textColor = .black
        v.text = "날짜를 골라주세요!"
        
        return v
    }()
    
    private lazy var pickTimeLabel : UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .bold13
        v.textColor = .black
        v.text = "행사 시작 시간을 골라주세요!"
        
        return v
        
    }()
    
    private lazy var confirmButton : RoundButton = {
        let v = RoundButton(heightType: .Height54)
        v.text = "확인"
        v.backgroundColor = .black
        v.setTitleColor(.white, for: .normal)
        v.layer.cornerRadius = 10
        v.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return v
    }()
    
    private var datePicker : UIDatePicker = {
        
        let v = UIDatePicker()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.locale = Locale(identifier: "ko")
        v.tintColor = .black
        
        return v
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        initView()
        
        
    }
    
    private func initView(){
    

        
        let views = [
        
            "pickDateLabel" : pickDateLabel,
            "datePicker" :datePicker,
            "confirmButton" : confirmButton
        ]
        
        view.addSubviews(pickDateLabel, datePicker, confirmButton)
        
        view.addConstraints("H:|-16-[pickDateLabel]|", views: views)
        view.addConstraints("H:|-16-[datePicker]|" , views : views )
        view.addConstraints("H:|-16-[confirmButton]-16-|", views : views )
        view.addConstraints("V:|-16-[pickDateLabel]-30-[datePicker]", views : views )
        view.addConstraints("V:[confirmButton]-40-|", views : views )
        pickDateLabel.activateCenterXConstraint(to: view)
        
    }
    

    
    @objc private func confirmButtonTapped(){
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.timeStyle = .short
        dateformatter.locale = Locale(identifier: "ko")
        
  
        let date = dateformatter.string(from: datePicker.date)
        Broadcast.EVENT_DATE_PICK_BROADCAST.onNext(date)
        self.dismiss(animated:true)
    }
    
    
}
