//
//  AppService.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation

import PromiseKit
import Alamofire

final class AppService {
    
    static func POST<T>(endPoint: String, params: Parameters? = nil, keyPath: String? = nil) -> Promise<T> where T: Decodable {
        return Service.request(endPoint: ServiceEnvironment.currentServer.apiHostURLString + endPoint, method: .post, params: params, keyPath: keyPath)
    }
    
    static func GET<T>(endPoint: String, params: Parameters? = nil, keyPath: String? = nil, otherDecoder : JSONDecoder? = nil) -> Promise<T> where T: Decodable {
        return Service.request(endPoint: ServiceEnvironment.currentServer.apiHostURLString + endPoint, method: .get, params: params, keyPath: keyPath, otherDecoder: otherDecoder)
    }
    
    static func PUT<T>(endPoint: String, params: Parameters? = nil, keyPath: String? = nil) -> Promise<T> where T: Decodable {
        return Service.request(endPoint: ServiceEnvironment.currentServer.apiHostURLString + endPoint, method: .put, params: params, keyPath: keyPath)
    }
    
    static func PATCH<T>(endPoint: String, params: Parameters? = nil, keyPath: String? = nil, otherDecoder : JSONDecoder? = nil, isUpload: Bool = false, files: [UploadFile] = []) -> Promise<T> where T: Decodable {
    
        if isUpload{
            return Service.upload(endPoint: ServiceEnvironment.currentServer.apiHostURLString + endPoint, method: .patch, files: files ,params: params,keyPath: keyPath,otherDecoder:otherDecoder)
        }else{
            return Service.request(endPoint: ServiceEnvironment.currentServer.apiHostURLString + endPoint, method: .patch, params: params, keyPath: keyPath, otherDecoder: otherDecoder)
        }
    }
    
    
    static func DELETE<T>(endPoint: String, params: Parameters? = nil, fields: Parameters? = nil, keyPath: String? = nil) -> Promise<T> where T: Decodable {
        return Service.request(endPoint: ServiceEnvironment.currentServer.apiHostURLString + endPoint, method: .delete, params: params, fields: fields, keyPath: keyPath)
    }
    
    static func POST<T>(endPoint: String, files: [UploadFile], params: Parameters? = nil, keyPath: String? = nil) -> Promise<T> where T: Decodable {
        return Service.upload(endPoint: ServiceEnvironment.currentServer.apiHostURLString + endPoint, method: .post, files: files, params: params, keyPath: keyPath)
    }
    
    static func PUT<T>(endPoint: String, files: [UploadFile], params: Parameters? = nil, keyPath: String? = nil) -> Promise<T> where T: Decodable {
        return Service.upload(endPoint: ServiceEnvironment.currentServer.apiHostURLString + endPoint, method: .put, files: files, params: params, keyPath: keyPath)
    }

}
