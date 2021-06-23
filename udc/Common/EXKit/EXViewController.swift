//
//  EXViewController.swift
//  udc
//
//  Created by 도로맥 on 2021/05/26.
//

import Foundation
import UIKit
import JGProgressHUD


class EXViewController: UIViewController {
    
    convenience init(_ style : UIModalPresentationStyle){
        self.init()
        modalPresentationStyle = style
    }
    
    /** 현재 화면이 전환돠고 있는 상태인지 판단한다. 이는 화면 전환중 다른 화면 전환 요청을 무시하는 데 쓰인다.
    
    - AppNavigator.swift
    */
    var isTransitioning = false
    
    /** 현재 showProgress, hideProgress 메서드를 통해 indicator가 보이는 상태인 지 나타낸다. 네트워크 요청이 진행되고 있다는 것을 의미하지는 않는다.*/
    var isProgressing = false
    
    private lazy var progressHud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .extraLight)
        hud.interactionType = .blockAllTouches
        return hud
    }()
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
//
//    var isLogined:Bool{
//        return AppModel.shared.currentUser != nil
//    }
//
//    var currentUser: User? {
//        // TODO: currentUser nil일 경우 로그인화면 이동처리?
//        return AppModel.shared.currentUser
//    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    deinit {
        /// Debug deallocation of ViewControllers for preventing memory leak
        //debugE("deinit \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .surfaceBlack
        /// For pop gesture re-enable(disabled by Hero)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    
    // viewSafeAreaInsetsDidChange에 해당하는 함수
    // 필요시 오버라이드
    func viewContentAreaInsetsDidChange() {
    }
    
    func showAlert(_ title: String, _ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //alert.addAction(UIAlertAction(title: Str.common_ok, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    func configureTPNavigationBar() {
        guard let nc = navigationController else {
            return
        }
        
        nc.navigationBar.shadowImage = UIImage()
        nc.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nc.navigationBar.tintColor = .white
        
        configureTitleTextToThemeColor(true)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    func configureTitleTextToThemeColor(_ theme : Bool){
        guard let nc = navigationController else {
            return
        }
        
        if theme{
            nc.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.theme]
        }else{
            nc.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
    
    func configureCustomNavigationBar() {
        
        guard let nc = navigationController else {
            return
        }
        
        nc.navigationBar.shadowImage = UIImage()
        nc.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nc.navigationBar.tintColor = .white
        configureTitleTextToThemeColor(true)
        
        let titleBar = UIView()
        titleBar.tag = 999
        titleBar.translatesAutoresizingMaskIntoConstraints = false
        titleBar.backgroundColor = .black
        
        view.subviews.filter{$0.tag == 999}.forEach{
            $0.removeFromSuperview()
        }
        
        view.addSubview(titleBar)
        
        NSLayoutConstraint.activate([
            titleBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleBar.topAnchor.constraint(equalTo: view.topAnchor),
            titleBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        // set backbutton title color to clear
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    func setGradientBackground(){
        //view.applyGradient(colours: [.theme2,.theme], locations: [0,1.0])
    }
    
    func showProgress() {
        self.progressHud.show(in: self.navigationController?.view ?? self.view)
        self.isProgressing = true
    }
    
    func hideProgress(afterDelay delay: TimeInterval = 0, animated: Bool = false) {
        self.progressHud.dismiss(afterDelay: delay, animated: animated)
        isProgressing = false
    }
    
    func addStatusBar(withColor color: UIColor){
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = color
            statusBar.tag = 100
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
    }
    func removeStatusBar(){
        if #available(iOS 13.0, *) {
            UIApplication.shared.keyWindow?.viewWithTag(100)?.removeFromSuperview()
        }
    }
}
