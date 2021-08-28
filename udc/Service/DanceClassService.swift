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
    
    
    static func fetchClasses( sort : String? = nil , day : Int? = nil, genreId : Int? = nil, academyId : Int? = nil ) -> Promise<[DanceClass]> {
        let params: Parameters = [
            "sort" : sort,
            "day" : day,
            "genreId" : genreId,
            "academyId" : academyId
            ].filterNotNil()
        return AppService.GET(endPoint: "/v1/class", params: params, keyPath: "data.classes")
    }
    
    static func fetchClass ( classId : Int) -> Promise<DanceClass> {
        return AppService.GET(endPoint: "/v1/class/\(classId)", params : nil , keyPath: "data.class", otherDecoder: nil)
    }
    
    static func fetchPopupClass () -> Promise<DanceClass> {
        
        return AppService.GET(endPoint: "/v1/popup/main", params : nil , keyPath : "data.class", otherDecoder: nil )
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
        
        return DanceClass.fetchClasses(sort : "main").then { (result: [DanceClass]) -> Promise<[DanceClass]> in
            
            self.reachedEnd = result.count < DanceClass.FETCH_COUNT
            if let lastItem = result.last {
                self.maxId = lastItem.id
            }

            return .value(result)

        }
    }
    
}

final class DayClassProvider : DanceClassProvider {
    
    static func newInstance(

    ) -> DanceClassProvider {
        let provider = DayClassProvider()
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
        
        return DanceClass.fetchClasses(day : 1).then { (result: [DanceClass]) -> Promise<[DanceClass]> in
            
            self.reachedEnd = result.count < DanceClass.FETCH_COUNT
            if let lastItem = result.last {
                self.maxId = lastItem.id
            }

            return .value(result)

        }
    }
    
}


final class GenreClassProvider : DanceClassProvider {
    
    static func newInstance(

    ) -> DanceClassProvider {
        let provider = GenreClassProvider()
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
        
        return DanceClass.fetchClasses(genreId : 1).then { (result: [DanceClass]) -> Promise<[DanceClass]> in
            
            self.reachedEnd = result.count < DanceClass.FETCH_COUNT
            if let lastItem = result.last {
                self.maxId = lastItem.id
            }

            return .value(result)

        }
    }
    
}


