//
//  UDCError.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation
enum UDCError: LocalizedError {
    
    case canNotParseJSON
    
    case notAllowed
    
    case uploadFlipFailed
    
    case uploadMergeFailed
    
    case uploadAddOverlayFailed
    
    case uploadVideoFailed
    
    case fcmTokenNotAvailable
    
    case cameraPermissionDenied
    
    case videoCacheFailed
    
    var localizedDescription: String {
        get {
            switch self {
                case .canNotParseJSON: return NSLocalizedString("알 수 없는 결과값입니다.", comment: "")
                case .notAllowed: return NSLocalizedString("사용이 제한된 기능입니다.", comment: "")
                case .fcmTokenNotAvailable: return NSLocalizedString("FCM 토큰을 가져오는 데 실패했습니다", comment: "")
                default: return NSLocalizedString("요청을 처리할 수 없습니다.", comment: "")
            }
        }
    }
}
