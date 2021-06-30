//
//  AppModel.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//
import Foundation

final class AppModel {
    
    // MARK: -  Properties
    
    static let shared = AppModel()
    
    private init(){}
    
    private let defaults = UserDefaults.standard
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    // MARK: -  UserDefaults Key-Value
    
    /**
    API Environment
    */
    var serviceEnvironment : Int{
        get{
            let rawValue = defaults.integer(forKey: "serviceEnvironment")
            if rawValue != ServiceEnvironment.development.rawValue && rawValue != ServiceEnvironment.production.rawValue{
                self.serviceEnvironment = ServiceEnvironment.defaultServer.rawValue
                return ServiceEnvironment.defaultServer.rawValue
            }
            return rawValue
        }
        set{
            defaults.set(newValue, forKey: "serviceEnvironment") }
    }
    
    /**
    Access Token for API
    */
    var accessToken : String{
        get{ defaults.string(forKey: "accessToken") ?? "" }
        set{ defaults.set(newValue, forKey: "accessToken") }
    }
    
    /**
    Refresh Token for refreshing accessToken
    */
    var refreshToken : String{
        get{ defaults.string(forKey: "refreshToken") ?? "" }
        set{ defaults.set(newValue, forKey: "refreshToken") }
    }
    
    /**
    Current User object
    */
    var currentUser : User?{
        get{
            guard let data: Data = defaults.data(forKey: "currentUser") else { return nil }
            return try? decoder.decode(User.self, from: data)
        }
        set{
            guard let data: Data = try? encoder.encode(newValue) else { return }
            defaults.set(data, forKey: "currentUser")
        }
    }
    
    /**
    Email from AppleID
    */
    var appleIDEmail: String?{
        get{ defaults.string(forKey: "appleIDEmail") }
        set{ defaults.set(newValue, forKey: "appleIDEmail") }
    }
    
    /**
    Email from AppleID
    */
    var appleIDFullName: String?{
        get{ defaults.string(forKey: "appleIDFullName") }
        set{ defaults.set(newValue, forKey: "appleIDFullName") }
    }
    
    /**
    현재 최신 약관동의 버전 - SplashVC 에서 API로 업데이트
    */
    var latestLegalNoticeVersion : String{
        get{ defaults.string(forKey: "latestLegalNoticeVersion") ?? "" }
        set{ defaults.set(newValue, forKey: "latestLegalNoticeVersion") }
    }
    
    /**
    권한 동의 화면을 보았는 지
    */
    var permissionInformationScreenSeen : Bool{
        get{ defaults.bool(forKey: "permissionInformationScreenSeen")}
        set{ defaults.set(newValue, forKey: "permissionInformationScreenSeen") }
    }
    
    /**
    기기 UUID for FCM
    */
    var deviceUUID : String?{
        get{ defaults.string(forKey: "deviceUUID") }
        set{ defaults.set(newValue, forKey: "deviceUUID") }
    }
    
    /**
    현재 업로드하고있는 UploadRequest의 id
    */
    var uploadingRequestId: Int{
        get{ defaults.integer(forKey: "uploadingRequestId") }
        set{ defaults.set(newValue, forKey: "uploadingRequestId") }
    }

    /**
    Block 시킨 유저의 id들을 로컬에 저장하기 위한 용도
    
    "(5-5),(5-25),(5-36)"
    */
    var blockedUserIds: [(Int, Int)]{
        get{
            let raw = defaults.string(forKey: "blockedUserIds") ?? ""
            
            return raw.split(separator: ",").compactMap{ raw in
                guard let currentUserId = Int(raw.split(separator: "-")[safe: 0] ?? "") else { return nil }
                guard let blockedUserId = Int(raw.split(separator: "-")[safe: 1] ?? "") else { return nil }
                
                return (currentUserId, blockedUserId)
            }
        }
        set{
            defaults.set(newValue.map{ (currentUserId, blockedUserId) in
                "\(currentUserId)-\(blockedUserId)"
            }.joined(separator: ","), forKey: "blockedUserIds")
        }
    }
    
    var lastLoginnedEmail: String{
        get{ defaults.string(forKey: "lastLoginnedEmail") ?? "" }
        set{ defaults.set(newValue, forKey: "lastLoginnedEmail") }
    }
    
    
    /*---------------------Fields End -----------------------*/
    
    
    // MARK: -  Util Functions

    /**
    User 상태를 Local Preferences 에서 Clear 한다.
    */
    func clearUserInfo() {
        accessToken = ""
        currentUser = nil
    }

}
