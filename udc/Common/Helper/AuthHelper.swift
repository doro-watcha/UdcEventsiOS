//
//  AuthHelper.swift
//  udc
//
//  Created by 도로맥 on 2021/07/28.
//
import Foundation
import RxSwift
import NaverThirdPartyLogin
class AuthHelper{
    
    
    static func logout(){
        do{
//            //FCM Unregister
//            UserDevice.unregisterUserDevice()
//            //Facebook Logout
//            facebookLoginManager.logOut()
//            //Firebase Authentication Logout
//            try Auth.auth().signOut()
//            //Google Logout
//            GIDSignIn.sharedInstance()?.signOut()
//            //Kakao Logout
//            KOSession.shared()?.logoutAndClose(completionHandler: {_,_ in})
            //UserDefaults Logout
            AppModel.shared.clearUserInfo()
            
            NaverThirdPartyLoginConnection.getSharedInstance()?.requestDeleteToken()

        }catch let error{
            CommonDialog.show(error.localizedDescription)
        }
    }
//
//    static func getFirebaseToken() -> Single<String>{
//        return Single.create{event in
//            InstanceID.instanceID().instanceID{result,e in
//                if e != nil || result?.token == nil{
//                    event(.error(e ?? BeatfloError.fcmTokenNotAvailable))
//                }
//                event(.success(result!.token))
//            }
//
//            return Disposables.create()
//        }
//    }
}
