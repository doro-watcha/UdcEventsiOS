//
//  EventService.swift
//  udc
//
//  Created by 도로맥 on 2021/07/11.
//

import Foundation
import PromiseKit

extension Event {
    
    static var FETCH_COUNT : Int{
        return 10
    }
    
    
    static func fetchEventBySort( sort : String ) -> Promise<[Event]> {
        let params: Parameters = [
            "sort": sort
            ].filterNotNil()
        return AppService.GET(endPoint: "/event", params: params, keyPath: "data.events")
    }
    


    
}


protocol EventProvider {
    /// information whether there is no more data to fetch from server
    var reachedEnd: Bool { get }
    
    /// In blocking process, the current user id is also paired with blocked user id becuase of situation that multiple user use same device.
    /// So this variable determines the content of blocked user is shown to current user
    var currentUserIdForBlocking: Int? { get }
    
    /// Fetch Video array instance from API server
    func fetchItems(refresh: Bool) -> Promise<[Event]>
    
    /// Factory Method
    static func newInstance() -> EventProvider

    
}

extension EventProvider{

}

final class MainEventProvider: EventProvider {
    
    static func newInstance(

    ) -> EventProvider {
        let provider = MainEventProvider()
        return provider
    }
    
    private init(){}
    
    var currentUserIdForBlocking: Int?
    var reachedEnd = false
    
    // additions
    private var maxId = Int(Int32.max)
    
    func fetchItems(refresh: Bool) -> Promise<[Event]> {
        if refresh { maxId = Int(Int32.max) }
        guard !reachedEnd else { return Promise.value([]) }
        
        return Event.fetchEventBySort(sort : "main").then { (result: [Event]) -> Promise<[Event]> in
            
            self.reachedEnd = result.count < Event.FETCH_COUNT
            if let lastItem = result.last {
                self.maxId = lastItem.id
            }

            return .value(result)

        }
    }
    
}

final class HotEventProvider : EventProvider {
    
    static func newInstance(

    ) -> EventProvider {
        let provider = HotEventProvider()
        return provider
    }
    
    private init(){}
    
    var currentUserIdForBlocking: Int?
    var reachedEnd = false
    
    // additions
    private var maxId = Int(Int32.max)
    
    func fetchItems(refresh: Bool) -> Promise<[Event]> {
        if refresh { maxId = Int(Int32.max) }
        guard !reachedEnd else { return Promise.value([]) }
        
        return Event.fetchEventBySort(sort: "hot").then { (result: [Event]) -> Promise<[Event]> in
            
            self.reachedEnd = result.count < Event.FETCH_COUNT
            if let lastItem = result.last {
                self.maxId = lastItem.id
            }

            return .value(result)

        }
    }
}


final class NewEventProvider : EventProvider {
    
    static func newInstance(

    ) -> EventProvider {
        let provider = NewEventProvider()
        return provider
    }
    
    private init(){}
    
    var currentUserIdForBlocking: Int?
    var reachedEnd = false
    
    // additions
    private var maxId = Int(Int32.max)
    
    func fetchItems(refresh: Bool) -> Promise<[Event]> {
        if refresh { maxId = Int(Int32.max) }
        guard !reachedEnd else { return Promise.value([]) }
        
        return Event.fetchEventBySort(sort: "new").then { (result: [Event]) -> Promise<[Event]> in
            
            self.reachedEnd = result.count < Event.FETCH_COUNT
            if let lastItem = result.last {
                self.maxId = lastItem.id
            }

            return .value(result)

        }
    }
}

final class EventCollectionProvider : EventProvider {
    
    
    static func newInstance(

    ) -> EventProvider {
        let provider = EventCollectionProvider()
        return provider
    }
    
    private init(){}
    
    var currentUserIdForBlocking: Int?
    var reachedEnd = false
    
    // additions
    private var maxId = Int(Int32.max)
    
    func fetchItems(refresh: Bool) -> Promise<[Event]> {
        if refresh { maxId = Int(Int32.max) }
        guard !reachedEnd else { return Promise.value([]) }
        
        return Event.fetchEventBySort(sort: "new").then { (result: [Event]) -> Promise<[Event]> in
            
            self.reachedEnd = result.count < Event.FETCH_COUNT
            if let lastItem = result.last {
                self.maxId = lastItem.id
            }

            return .value(result)

        }
    }
    
}

