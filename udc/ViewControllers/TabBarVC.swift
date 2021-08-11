//
//  TabBarVC.swift
//  udc
//
//  Created by 도로맥 on 2021/05/26.
//

import Foundation
import UIKit
import PromiseKit
import MaterialComponents

class TabBarVC: UITabBarController, UITabBarControllerDelegate, UINavigationControllerDelegate {
    
    /**
    실제 인덱스와 각 탭의 VC에 TabBarItem에 넣어둔 태그번호를 매핑해준 딕셔너리
    */
    static let indexTagMapper = [0:1, 1:2, 2:4, 3:5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        
        tabBar.barTintColor = .black
        tabBar.isTranslucent = true
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = .white
        

        
        let vc1 =  ClassVC()
        let vc2 = MapVC()
        let vc4 =  HomeVC()
        let vc5 =  ProfileVC()
        
        vc1.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "feedPurple100"), tag: TabBarVC.indexTagMapper[0]!)
        vc2.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "music"), tag: TabBarVC.indexTagMapper[1]!)
        vc4.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "notif"), tag: TabBarVC.indexTagMapper[2]!)
        vc5.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profilePurple100"), tag: TabBarVC.indexTagMapper[3]!)
     
        
//        vc1.delegate = self
//        vc2.delegate = self
////        vc3.delegate = self
//        vc4.delegate = self
//        vc5.delegate = self
        
        viewControllers = [ vc1, vc2, vc4,vc5]
      


        
    }

    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if [viewControllers?[2], viewControllers?[3]].contains(viewController){

//            if AppModel.shared.currentUser == nil{
                
                presentLoginDialog{[weak self] in
                    self?.dismiss(animated: true, completion: nil)
                }
                
                return false
//            }
            return true
            
        }else{
            return true
        }
    }
    
    /**
    로그인 요청 화면
    */
    private func presentLoginDialog(_ onTapLogin: @escaping () -> Void){
        let vc = LoginVC()
//        vc.onTapLogin = onTapLogin
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}

