//
//  ClassService.swift
//  udc
//
//  Created by 도로맥 on 2021/07/22.
//

import Foundation
import PromiseKit

extension DanceClass {
    
    static var FETCH_COUNT : Int{
        return 10
    }
    
    
    static func fetchMainClasses() -> Promise<[DanceClass]> {
        let params: Parameters = [
            "sort": "main"
            ].filterNotNil()
        return AppService.GET(endPoint: "/class", params: params, keyPath: "data.classes")
    }


    
}


protocol DanceClassProvider {
    /// information whether there is no more data to fetch from server
    var reachedEnd: Bool { get }
    
    /// In blocking process, the current user id is also paired with blocked user id becuase of situation that multiple user use same device.
    /// So this variable determines the content of blocked user is shown to current user
    var currentUserIdForBlocking: Int? { get }
    
    /// Fetch Video array instance from API server
    func fetchItems(refresh: Bool) -> Promise<[DanceClass]>
    
    /// Factory Method
    static func newInstance() -> DanceClassProvider

    
}

extension MainClassProvider {
    
    
}


final class MainClassProvider : DanceClassProvider {
    
    static func newInstance(

    ) -> DanceClassProvider {
        let provider = MainClassProvider()
        return provider
    }
    
    private init(){}
    
    var currentUserIdForBlocking: Int?
    var reachedEnd = false
    
    // additions
    private var maxId = Int(Int32.max)
    
    func fetchItems(refresh: Bool) -> Promise<[DanceClass]> {
        if refresh { maxId = Int(Int32.max) }
        guard !reachedEnd else { return Promise.value([]) }
        
        return DanceClass.fetchMainClasses().then { (result: [DanceClass]) -> Promise<[DanceClass]> in
            
            self.reachedEnd = result.count < DanceClass.FETCH_COUNT
            if let lastItem = result.last {
                self.maxId = lastItem.id
            }

            return .value(result)

        }
    }
    
}
