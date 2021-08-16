//
//  AppNavigator.swift
//  udc
//
//  Created by 도로맥 on 2021/06/20.
//

import UIKit
import SafariServices
import MaterialComponents
import MessageUI
import StoreKit
import SPPermissions
import RxSwift


extension EXViewController: UIViewControllerTransitioningDelegate {
    func presentModal(_ presentedVC: UIViewController, animated: Bool = true){
        guard !isTransitioning else { return }
        isTransitioning = true
        self.present(presentedVC, animated: animated, completion: { [weak self] in
            self?.isTransitioning = false
        })
    }

    func pushToNaviVC(_ pushedVC: UIViewController, animated: Bool = true){
        guard !isTransitioning else { return }
        isTransitioning = true
        self.navigationController?.pushViewController(pushedVC, animated: animated)

        let _ = Single.timer(0.5, scheduler: MainScheduler.instance).subscribe(onSuccess: {[weak self] (t: Int) in
            self?.isTransitioning = false
            }, onError: {_ in })
    }
    
    /** 프로필 - About 화면 */
    func presentUpload(){
        let vc = EventUploadVC()
        
        debugE("presetUpload")

        self.pushToNaviVC(vc)
    }
    
    func presetEventDetail( event : Event ) {
        
        let vc = EventDetailVC()
        vc.event = event 
        self.pushToNaviVC(vc)
    }

    func presentSetting() {
        
        let vc = SettingVC()
        self.pushToNaviVC(vc)
    }
    
    func presentClassDetail ( classId : Int) {
        
        let vc = ClassDetailVC()
        vc.classId = classId 
        self.pushToNaviVC(vc)
    }
}
