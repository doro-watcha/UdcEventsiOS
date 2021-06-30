//
//  ErrorCode.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation

enum ErrorCode: Int{
    case networkDisconnected = -1
    
    case requestBodyFail = 100
    case emailAlreadyVerifed = 101
    case emailInvalidFormat = 102
    
    case passwordInvalid = 200 // 패스워드가 틀림
    case tokenInvalid = 201
    case emailUnverified = 202
    case termsOfAgreeNotAgreed = 203
    
    case resourcesForbidden = 300
    
    case userNotFound = 402
    case videoNotFound = 403
    case commentNotFound = 404
    case musicNotFound = 405
    case bookmarkNotFound = 406
    case notificationNotFound = 407
    case notificationTypeNotFound = 408
    case artistNotFound = 410
    case deviceNotFound = 412
    case likeNotFound = 413
    case userNotificationSettingNotFound = 418
    case contentNotFound = 420
    case partNotFound = 421
    case tagNotFound = 422
    case promoNotFound = 423
    case socialChannelNotFound = 424
    case socialChannelVideoNotFound = 425
    case userPaymentMethodNotFound = 426
    
    case userAlreadyExist = 500
    case bookmarkAlreadyExist = 501
    case likeAlreadyExist = 502
    case tagAlreadyExist = 506
    case socialChannelAlreadyExist = 507
    case urlAlreadyExist = 508
    case samePartAndSameSocialChannelVideoAlreadyExist = 509
    case promoInMusicAlreadyExist = 510
    
    case userDeleted = 600
    case videoDeleted = 601
    case commentDeleted = 602
    
    case serverError = 700
    case foreignKeyConstraintFail = 701
    
    init?(e: Error){
        guard let serviceError = e as? ServiceError else { return nil }
        self.init(statusCode: serviceError.ecode)
    }
    
    init?(statusCode: Int){
        guard let errorCode = ErrorCode(rawValue: statusCode) else { return nil }
        self = errorCode
    }
    
    var errorCode: Int{
        self.rawValue
    }
    
    // TODO: 정리해야 함
    var localizedDescription: String?{
        switch self{
//            // MARK: - 100
//            case .emailInvalidFormat:
//                return Str.error_email_regex_invalid
//            // MARK: - 200
//            case .passwordInvalid:
//                return Str.error_password_invalid
//            case .tokenInvalid:
//                return Str.error_token_expired
//            case .emailUnverified:
//                return Str.error_unverified_account
//            case .termsOfAgreeNotAgreed:
//                return Str.error_terms_need_agree
//            // MARK: - 400
//            case .userNotFound:
//                return Str.error_account_not_found
//            // MARK: - 500
//            case .userAlreadyExist:
//                return Str.error_account_already_exist
//            case .userDeleted, .videoDeleted, .commentDeleted:
//                return Str.error_deleted_content
//            case .networkDisconnected:
//                return Str.error_network
            
            default: return Str.error_common
        }
    }
}

extension Error{
    var errorCode: ErrorCode?{
        ErrorCode(e: self)
    }
}

extension Int{
    var errorMessage: String?{
        return ErrorCode(statusCode: self)?.localizedDescription
    }
}
