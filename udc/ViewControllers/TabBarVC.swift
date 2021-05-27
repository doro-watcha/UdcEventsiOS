//
//  TabBarVC.swift
//  udc
//
//  Created by 도로맥 on 2021/05/26.
//

import Foundation
import UIKit
import PromiseKit
import Firebase
import MaterialComponents

final class TabBarVC: UITabBarController, UINavigationControllerDelegate, UITabBarControllerDelegate {
    
    /**
    실제 인덱스와 각 탭의 VC에 TabBarItem에 넣어둔 태그번호를 매핑해준 딕셔너리
    */
    static let indexTagMapper = [0:1, 1:2, 2:4, 3:5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugE("TAbBarVC")
        
        self.delegate = self
        
//        self.heroTabBarAnimationType = .fade
        
        let vc1 = UINavigationController(rootViewController: HomeVC())
        let vc2 = UINavigationController(rootViewController: MapVC())
        let vc4 = UINavigationController(rootViewController: ClassVC())
        let vc5 = UINavigationController(rootViewController: ProfileVC())
        
        vc1.tabBarItem = UITabBarItem(title: "home", image: UIImage(named: "udc_events"), tag: TabBarVC.indexTagMapper[0]!)
        vc2.tabBarItem = UITabBarItem(title: "asd", image: UIImage(named: "udc_events"), tag: TabBarVC.indexTagMapper[1]!)
        //        vc3.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(named: "explore"), tag: 3)
        vc4.tabBarItem = UITabBarItem(title: "fdf", image: UIImage(named: "udc_events"), tag: TabBarVC.indexTagMapper[2]!)
        vc5.tabBarItem = UITabBarItem(title: "sdd", image: UIImage(named: "udc_events"), tag: TabBarVC.indexTagMapper[3]!)
        
        
        vc1.delegate = self
        vc2.delegate = self
//        vc3.delegate = self
        vc4.delegate = self
        vc5.delegate = self
        
        viewControllers = [vc1, vc2, /* v3 ,*/ vc4, vc5]
        
//        /// Hero
//        vc1.hero.isEnabled = true
//        vc2.hero.isEnabled = true
//                //vc3.hero.isEnabled = true
//        vc4.hero.isEnabled = true
//        vc5.hero.isEnabled = true
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
//        /// 새로운 탭을 클릭한 거라면 모든 비디오 중지
//        if TabBarVC.indexTagMapper[selectedIndex] != item.tag{
//            Broadcast.VIDEO_ALL_STOP.onNext(())
//        }
//        /// 동일한 탭을 클릭한 것이라면 해당 탭 재선택 이벤트 발송
//        else{
//            Broadcast.TABBAR_RESELECT.onNext(item.tag)
//        }

    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if [viewControllers?[2], viewControllers?[3]].contains(viewController){

//            if AppModel.shared.currentUser == nil{
//
//                presentLoginDialog{[weak self] in
//                    self?.dismiss(animated: true, completion: nil)
//                }
//
//                return false
//            }
            return true

        }else{
            return true
        }
        return true 
    }
    
    /**
    로그인 요청 화면
    */
    private func presentLoginDialog(_ onTapLogin: @escaping () -> Void){
//        let vc = LoginDialogVC()
//        vc.onTapLogin = onTapLogin
//        let bottomSheetVC = MDCBottomSheetController(contentViewController: vc)
//        bottomSheetVC.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
//        present(bottomSheetVC, animated: true, completion: nil)
    }
        
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        /// 스크린이 변했을 때 모든 비디오 pause, 다시 play는 각 VC의 viewDidAppear에서 설정해줌
      //  Broadcast.VIDEO_ALL_STOP.onNext(())
    }
}

