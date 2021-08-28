//
//  User.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation


import Foundation
import PromiseKit

extension User {

    /** 토큰 Validation - 자동 로그인시 */
    static func checkTokenValidation() -> Promise<VoidResult>{
        return AppService.GET(endPoint: "/auth")
    }

    
    /**
    Email/PW 를 이용한 로그인
    
    AppModel을 이용해 Token과 현재 유저를 저장한다
    */
    static func signInWithSns(loginType : String, username : String, profileImageUrl : String, userId : String  ) -> Promise<User> {
        let params: Parameters = [
            "loginType": loginType,
            "username": username,
            "profileImgUrl" : profileImageUrl,
            "loginId" : userId
            ].filterNotNil()
        return AppService.POST(endPoint: "/v1/auth/social-signin",  params: params, keyPath: "data").then { (result: SignInResultWrapper) -> Promise<User> in
            AppModel.shared.accessToken = result.token
            AppModel.shared.currentUser = result.user
            return .value(result.user)
        }
    }
    
    /**
    이메일을 이용한 회원가입
    */
    static func signUpWithEmail(email : String, password: String) -> Promise<User>{
        let params:  Parameters = ["email" : email, "password" : password]
        
        return AppService.POST(endPoint: "/auth/signup", params: params, keyPath: "data.user")
    }
    
    /**
    SNS를 이용한 로그인
//    */
//    static func signInWithSNS(socialUuid : String, loginType : LoginType, acceptedLegalNoticeVersion: String?) -> Promise<User>{
//        let params : Parameters = [
//            "acceptedLegalNoticeVersion" : acceptedLegalNoticeVersion,
//            "socialUuid" : socialUuid,
//            "loginType" : loginType.rawValue,
//            "name": " "
//        ].filterNotNil()
//
//        return AppService.POST(endPoint: "/auth/social", params: params, keyPath: "data").then{ (result: SignInResultWrapper) -> Promise<User> in
//            if result.user.loginType == .apple{
//                AppModel.shared.appleIDEmail = result.user.email
//                AppModel.shared.appleIDFullName = result.user.name
//            }
//            AppModel.shared.accessToken = result.token
//            AppModel.shared.currentUser = result.user
//            return .value(result.user)
//        }
//    }
    
    /**
    SNS를 이용한 회원가입
    */
//    static func signUpWithSNS(email : String, name : String, avatarUrl : String?, socialUuid : String, loginType : LoginType, acceptedLegalNoticeVersion : String) -> Promise<User>{
//
//        let convertedEmail: String?
//        if email.isEmpty{
//            convertedEmail = nil
//        }else{
//            convertedEmail = email
//        }
//
//        let convertedAvatarUrl: String?
//        if avatarUrl == nil || avatarUrl!.trim().isEmpty{
//            convertedAvatarUrl = nil
//        }else{
//            convertedAvatarUrl = avatarUrl!
//        }
//
//        let params : Parameters = [
//            "email" : convertedEmail,
//            "name" : name,
//            "avatarUrl" : convertedAvatarUrl,
//            "socialUuid" : socialUuid,
//            "loginType" : loginType.rawValue,
//            "acceptedLegalNoticeVersion" : acceptedLegalNoticeVersion
//        ].filterNotNil()
//
        
        
//        return AppService.POST(endPoint: "/auth/social", params: params, keyPath: "data").then{ (result: SignInResultWrapper) -> Promise<User> in
//            if result.user.loginType == .apple{
//                AppModel.shared.appleIDEmail = result.user.email
//                AppModel.shared.appleIDFullName = result.user.name
//            }
//            AppModel.shared.accessToken = result.token
//            AppModel.shared.currentUser = result.user
//            return .value(result.user)
//        }
//    }
    
    /**
    비밀번호 재설정 이메일을 보낸다
    */
    static func sendResetPasswordEmail(_ email : String) -> Promise<User>{
        let params : Parameters = ["email" : email]
        
        return AppService.POST(endPoint: "/auth/send-reset-password", params: params, keyPath: "data.user")
    }
    
    /** 이메일 인증 이메일읇 보낸다 */
    static func sendEmailVerificationEmail(_ email: String) -> Promise<VoidResult>{
        let params : Parameters = ["email" : email]
        
        return AppService.POST(endPoint: "/auth/send-email-verification", params: params)
    }
    
//    /**
//    알림 설정을 받는다
//    */
//    static func getNotificationSetting(userId : Int) -> Promise<UserNotificationSetting>{
//        let otherDecoder = JSONDecoder()
//        otherDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
//        return AppService.GET(endPoint: "/user/\(userId)/notificationSetting", params: nil, keyPath: "data.userNotificationSetting",otherDecoder : otherDecoder)
//    }
    
    /**
    알림 설정을 한다.
    */
//    static func updateNotificationSetting(userId : Int, setting: UserNotificationSetting) -> Promise<UserNotificationSetting>{
//        let params:Parameters = [
//            "ALL" : setting.allOn,
//            "NEW_VIDEO" : setting.newVideoOn,
//            "LIKE" : setting.likeOn,
//            "COMMENT" : setting.commentOn,
//            "NEW_MUSIC" : setting.newMusicOn,
//            "FEATURED_VIDEO" : setting.newMyFeaturedVideoOn
//        ].filterNotNil()
//
//        let otherDecoder = JSONDecoder()
//        otherDecoder.dateDecodingStrategy =  .formatted(DateFormatter.iso8601Full)
//
//        return AppService.PATCH(endPoint: "/user/\(userId)/notificationSetting", params: params, keyPath: "data.userNotificationSetting",otherDecoder: otherDecoder)
//    }
//
    /**
    비밀번호 변경
    */
    static func updatePassword(userId : Int, curPassword : String, newPassword : String) -> Promise<User>{
        let params:Parameters = ["currentPassword" : curPassword, "newPassword" : newPassword].filterNotNil()
        
        return AppService.PATCH(endPoint: "/user/\(userId)", params: params, keyPath: "data.user",isUpload: true)
    }
    
    /**
    프로필/커버 이미지 변경
    */
    static func updateProfileCoverImage(userId: Int,files : [UploadFile]) -> Promise<User>{
        return AppService.PATCH(endPoint: "/user/\(userId)", params: nil, keyPath: "data.user", otherDecoder: nil, isUpload: true, files: files).then{ (result: User) -> Promise<User> in
            AppModel.shared.currentUser = result
            
            return .value(result)
        }
    }
    
    /**
    기타 정보 변경
    */
    static func updateProfileInformations(userId : Int, nickName : String? = nil, userName: String? = nil, bio: String? = nil, credentials: String? = nil) -> Promise<User>{
        let params : Parameters = [
            "name": nickName,
            "username" : userName,
            "bio" : bio,
            "credentials" : credentials
        ].filterNotNil()
        
        return AppService.PATCH(endPoint: "/user/\(userId)", params: params, keyPath: "data.user", otherDecoder: nil, isUpload: true).then{(result: User) -> Promise<User> in
            AppModel.shared.currentUser = result
            
            return .value(result)
        }
    }
    
    /**
    계정 삭제
    */
    static func deleteAccount(userId : Int, reason : String) -> Promise<VoidResult>{
        let params = ["reason" : reason].filterNotNil()
        
        return AppService.DELETE(endPoint: "/user/\(userId)", fields : params)
    }
    
    /**
    유저 정보 가져오기
    */
    static func getUser(userId: Int) -> Promise<User>{
        return AppService.GET(endPoint: "/user/\(userId)", params: nil, keyPath: "data.user", otherDecoder: nil)
    }
    
}

fileprivate struct SignInResultWrapper: Decodable {
    var token = ""
    var user: User
}
