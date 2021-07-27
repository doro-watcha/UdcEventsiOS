//
//  Service.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation
import PromiseKit
import Alamofire

enum ServiceEnvironment: Int, CaseIterable, Codable {
    
    static let defaultServer = ServiceEnvironment.development
    static var currentServer: ServiceEnvironment{
        ServiceEnvironment(rawValue: AppModel.shared.serviceEnvironment)!
    }
    
    case development = 1
    case production = 2
    
    var apiHostURLString: String {
        switch self {
            case .development : return "http://ec2-3-35-4-201.ap-northeast-2.compute.amazonaws.com:3000"
            case .production: return "http://ec2-13-209-64-88.ap-northeast-2.compute.amazonaws.com:3000"
        }
    }

    
    enum CodingKeys: String, CodingKey{
        case development = "development"
        case production = "production"
    }
    
}


final class Service {
    
    static func request<T>(endPoint: String, method: HTTPMethod, params: Parameters? = nil, fields: Parameters? = nil, keyPath: String? = nil, otherDecoder: JSONDecoder? = nil) -> Promise<T> where T: Decodable {
        var urlString = endPoint
        let headers: HTTPHeaders = ["Content-Type": "application/json",
                                    "Accept-Language": Locale.current.languageCode ?? "en",
                                    "Authorization": "JWT \(AppModel.shared.accessToken)"]
        var parameters = params
        var queryString = ""
        
        if method == .get || method == .delete {
            if let params = params {
                queryString = params.compactMap({ "\($0)=\($1)" }).joined(separator: "&")
                urlString += "?\(queryString)"
            }
            parameters = fields
        }
        
        
        
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.configuration.timeoutIntervalForRequest = 8
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
        
        return sessionManager.request(urlString, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(contentType: ["application/json"])
            .responseData().then { (data, response) -> Promise<T> in
                
                let decoder : JSONDecoder
                
                if otherDecoder != nil{
                    decoder = otherDecoder!
                }else{
                    decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                }
                
//
//                 //호출결과 에러값이 오는 경우
//                if let serviceError = try? decoder.decode(UDCError.self, from: data) {
//                    if !serviceError.success {
//                        throw serviceError
//                    }
//                }
//
                do {
                    let value = try decoder.decode(T.self, from: data, keyPath: keyPath)
                    return .value(value)
                } catch {
                    debugE(error)
                    throw error
                }
                
        }
    }
    
    static func upload<T>(endPoint: String, method: HTTPMethod, files: [UploadFile], params: Parameters? = nil, keyPath: String? = nil, otherDecoder : JSONDecoder? = nil) -> Promise<T> where T: Decodable {
        var urlString = endPoint
        let headers: HTTPHeaders = ["Content-Type": "application/json",
                                    "Accept-Language": Locale.current.languageCode ?? "en",
                                    "Authorization": "JWT \(AppModel.shared.accessToken)"]
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
        
        return Promise { seal in
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    
                    if let params = params {
                        for (key, value) in params {
                            if value is String || value is Int {
                                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                            }
                        }
                    }
                    
                    for file in files {
                        debugE("file: \(file.name) \(file.fileName)")
                        multipartFormData.append(file.data, withName: file.name, fileName: file.fileName, mimeType: file.mimeType)
                    }
                    
            },
                to: urlString,
                method: method,
                headers: headers) { (encodingResult) in
                    
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.uploadProgress(closure: { progress in
                            debugE(progress)
                        })
                        upload.responseJSON { response in
                            debugE("response:")
                            debugE(response)
                            
                            guard let data = response.data else {
                                seal.reject(UDCError.canNotParseJSON)
                                return
                            }
                            
                            let decoder : JSONDecoder
                            
                            if otherDecoder != nil{
                                decoder = otherDecoder!
                            }else{
                                decoder = JSONDecoder()
                                decoder.keyDecodingStrategy = .convertFromSnakeCase
                                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                            }
                            
                            // 호출결과 에러값이 오는 경우
                            if let serviceError = try? decoder.decode(ServiceError.self, from: data) {
                                if !serviceError.success {
                                    seal.reject(serviceError)
                                }
                            }
                            
                            do {
                                let value = try decoder.decode(T.self, from: data, keyPath: keyPath)
                                seal.fulfill(value)
                            } catch {
                                debugE(error)
                                seal.reject(error)
                            }
                        }
                        
                    case .failure(let encodingError):
                        seal.reject(encodingError)
                    }
            }
        }
    }
    
}

final class NaverService {

    
    static func request<T>(endPoint: String, method: HTTPMethod, params: Parameters? = nil, fields: Parameters? = nil, keyPath: String? = nil, otherDecoder: JSONDecoder? = nil) -> Promise<T> where T: Decodable {
        var urlString = endPoint
        let headers: HTTPHeaders = ["Content-Type": "application/json",
                                    "Accept-Language": Locale.current.languageCode ?? "en",
                                    "X-NCP-APIGW-API-KEY": "6vwzVaUiBFyV6nRNWeJQXbVffFaUY0XjIMsSQ41T",
                                    "X-NCP-APIGW-API-KEY-ID" : "86uizs8uuf"
        ]
        var parameters = params
        var queryString = ""
        
        if method == .get || method == .delete {
            if let params = params {
                queryString = params.compactMap({ "\($0)=\($1)" }).joined(separator: "&")
                urlString += "?\(queryString)"
            }
            parameters = fields
        }
        
        
        
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.configuration.timeoutIntervalForRequest = 8
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
        
        return sessionManager.request(urlString, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(contentType: ["application/json"])
            .responseData().then { (data, response) -> Promise<T> in
                
                let decoder : JSONDecoder
                
                if otherDecoder != nil{
                    decoder = otherDecoder!
                }else{
                    decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                }
                
//
//                 //호출결과 에러값이 오는 경우
//                if let serviceError = try? decoder.decode(UDCError.self, from: data) {
//                    if !serviceError.success {
//                        throw serviceError
//                    }
//                }
//
                do {
                    let value = try decoder.decode(T.self, from: data, keyPath: keyPath)
                    return .value(value)
                } catch {
                    debugE(error)
                    throw error
                }
                
        }
    }
    
}


struct UploadFile {
    var data: Data!
    var name = ""
    var fileName = ""
    var mimeType = ""
}




//
// 결과값이 불필요한 경우에 Promise<Void>를 사용하면
// AppService.request<T> 메소드를 통해 일반화하기 힘들기에 비어있는 Decodable struct 활용
//
struct VoidResult: Decodable {
}


//
// Promise<Void> 리턴시 `return .void` 형식으로 간략화하기 위한 처리 (`return Promise(value: ())` 와 동일)
// 참고: https://github.com/mxcl/PromiseKit/issues/532
//
extension Promise {
    static var voidResult: Promise<VoidResult> {
        return .value(VoidResult())
        //        return Promise<VoidResult>(value: VoidResult())
    }
}



protocol ServiceErrorHandler {
    
    func handleServiceError(_ error: ServiceError)
    
}





extension String {
    
    var fullDataURL: URL? {
        get {
            return self.isEmpty ? nil : URL(string: self)
        }
    }
    
}

