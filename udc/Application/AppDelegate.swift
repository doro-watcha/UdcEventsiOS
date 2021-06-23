//
//  AppDelegate.swift
//  udc
//
//  Created by 도로맥 on 2021/05/26.
//

import UIKit
import PromiseKit
import AVFoundation
import AlamofireNetworkActivityLogger
import RxSwift
import AuthenticationServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: -Variables
    var window: UIWindow?
    
    let sharedDisposeBag = DisposeBag()
    
    // MARK: -Initalization
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /**
        Firebase Configuration
        */
       // FirebaseApp.configure()
        

        
        /**
        Appearance API UI Settings
        */
        UITabBar.appearance().tintColor = .theme
        UITabBar.appearance().barTintColor = .surfaceBlack
//
        /**
        Root VC Intiailization for make view without Storyboard
        */
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.tintColor = .theme
//
//        /// App Running from notification
//        if launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] != nil{
//            let userInfo = launchOptions![UIApplication.LaunchOptionsKey.remoteNotification] as! [AnyHashable: Any]
//            let _ = NotificationHelper.navigateWithNotification(window: window!, userInfo: userInfo, isAppRunning: false)
//        }else{ /// App Running from general launch floww
            window!.rootViewController = TabBarVC()
//        }
//
        debugE("why not")
        window!.makeKeyAndVisible()
//
//        /**
//        Etc Settings
//        */
////        startAlamofireLogging()
//        setAudioCategory()
//        setFCMNotification(application)
//
//        AppModel.shared.uploadingRequestId = 0
//        observeUploadTarget()
//
        return true
    }
    

    
    private func startAlamofireLogging(){
        #if DEBUG
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
        #endif
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        if DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) != nil {
//            // Handle the deep link. For example, show the deep-linked content or
//            // apply a promotional offer to the user's account.
//            // ...
//            return true
//        }

        return true 
        
       // return GIDSignIn.sharedInstance().handle(url)
    }

//    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
//                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
////        let handled = DynamicLinks.dynamicLinks().handleUniversalLink(userActivity.webpageURL!) { (dynamiclink, error) in
////            // ...
////        }
//        
//    //    return handled
//    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        

        
        application.applicationIconBadgeNumber = 0
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        //AppModel.shared.uploadingRequestId = 0
    }
  
    
    
    
}

