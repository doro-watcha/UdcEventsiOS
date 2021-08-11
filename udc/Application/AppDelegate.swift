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
import NMapsMap
import NaverThirdPartyLogin

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
        
        // Naver Login
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        
        // 네이버 앱으로 인증하는 방식을 활성화
        instance?.isNaverAppOauthEnable = true
        
        // SafariViewController에서 인증하는 방식을 활성화
        instance?.isInAppOauthEnable = true
        
        // 인증 화면을 iPhone의 세로 모드에서만 사용하기
        instance?.isOnlyPortraitSupportedInIphone()
        
        // 네이버 아이디로 로그인하기 설정
        // 애플리케이션을 등록할 때 입력한 URL Scheme
        instance?.serviceUrlScheme = kServiceAppUrlScheme
        // 애플리케이션 등록 후 발급받은 클라이언트 아이디
        instance?.consumerKey = kConsumerKey
        // 애플리케이션 등록 후 발급받은 클라이언트 시크릿
        instance?.consumerSecret = kConsumerSecret
        // 애플리케이션 이름
        instance?.appName = kServiceAppName
        

        
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
        
        let navigationController = UINavigationController(rootViewController: TabBarVC())
        navigationController.setNavigationBarHidden(true, animated: false)
        window!.rootViewController = navigationController
    
        
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


        NMFAuthManager.shared().clientId = "86uizs8uuf"


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
        
        NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)

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
  
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        NaverThirdPartyLoginConnection
        .getSharedInstance()?
        .receiveAccessToken(URLContexts.first?.url)
    }

    
}

