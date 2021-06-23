//
//  AppNavigator.swift
//  udc
//
//  Created by 도로맥 on 2021/06/20.
//

import Foundation
import UIKit


extension EXViewController: UIViewControllerTransitioningDelegate {
    func presentModal(_ presentedVC: UIViewController, animated: Bool = true){
        guard !isTransitioning else { return }
        isTransitioning = true
        self.present(presentedVC, animated: animated, completion: { [weak self] in
            self?.isTransitioning = false
        })
    }

//    func pushToNaviVC(_ pushedVC: UIViewController, animated: Bool = true){
//        guard !isTransitioning else { return }
//        isTransitioning = true
//        self.navigationController?.pushViewController(pushedVC, animated: animated)
//        let _ = Single.timer(0.5, scheduler: MainScheduler.instance).subscribe(onSuccess: {[weak self] (t: Int) in
//            self?.isTransitioning = false
//            }, onError: {_ in })
//    }

}
