//
//  User.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation

final class User: Codable {
    var id : Int = 0
    
    var profileImgUrl : String = ""

    
    var _username: String?
    var username: String { return _username ?? "" }
    
    var _nickname : String?
    var nickname : String { return _nickname ?? ""}
    
    var _loginType : String?
    var loginType : String { return _loginType ?? ""}

    
    var _email: String?
    var email: String { return _email ?? "" }
    

    
    /// -- field end -- ///
    
    
    var avatarUrl: URL? { return URL(string: profileImgUrl) }
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case username = "username"
//        case avatarUrl = "proflieImgUrl"
//        case nickname = "nickname"
//        case email = "email"
//        case loginType = "loginType"
//    }
//
//
//    var isMe: Bool {
//        guard let currentUser = AppModel.shared.currentUser else { return false }
//        return (self.id == currentUser.id)
//    }
//
//    var isNotMe: Bool {
//        return !self.isMe
//    }
//
//    func copy(with zone: NSZone? = nil) -> Any {
//        let new = User()
//        new.id = id
//        new.profileImgUrl = profileImgUrl
//        new._nickname = _nickname
//        new._username = _username
//        new._loginType = _loginType
//        new._email = _email
//        return new
//    }
}
