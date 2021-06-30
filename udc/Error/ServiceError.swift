//
//  ServiceError.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation

/** API 서버와의 연결에서 에러가 발생한 경우이다. 서버와의 통신은 성공했지만 논리적으로 성공을 못한 경우이다. */
struct ServiceError: Decodable, Error, LocalizedError {
    
    var success = false
    var ecode = 0
    var message = ""
    
    var errorDescription: String? { return message }
    
    var needsHandleError: Bool {
        get {
            return needsReissueTokens || needsLogin
        }
    }
    
    var needsSilentFail: Bool {
        get {
            return needsReissueTokens
        }
    }
    
    var needsReissueTokens: Bool {
        get {
            //            return resultCode == 2203 // 만료된 토큰 (Refresh Token 사용하여 재발급 요청 필요)
            return false
        }
    }
    
    var needsLogin: Bool {
        get {
            //            return resultCode == 2200 // 토큰 인증 실패
            //                || resultCode == 2201 // 헤더에 토큰이 비어 있는 경우
            //                || resultCode == 2202 // 유효하지 않은 토큰
            return false
        }
    }
    
}
