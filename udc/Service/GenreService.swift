//
//  GenreService.swift
//  udc
//
//  Created by 도로맥 on 2021/08/12.
//

import Foundation
import PromiseKit

extension Genre {
    
    static var FETCH_COUNT : Int{
        return 10
    }
    
    
    static func fetchGenres() -> Promise<[Genre]> {

        return AppService.GET(endPoint: "/genre", keyPath: "data.genres")
    }



    
}


protocol GenreProvider {
    /// information whether there is no more data to fetch from server
    var reachedEnd: Bool { get }
    
    /// In blocking process, the current user id is also paired with blocked user id becuase of situation that multiple user use same device.
    /// So this variable determines the content of blocked user is shown to current user
    var currentUserIdForBlocking: Int? { get }
    
    /// Fetch Video array instance from API server
    func fetchItems(refresh: Bool) -> Promise<[Genre]>
    
    /// Factory Method
    static func newInstance() -> GenreProvider
    

    
}



final class GenreNameProvider : GenreProvider {
    
    static func newInstance(

    ) -> GenreProvider {
        let provider = GenreNameProvider()
        return provider
    }
    
    private init(){}
    
    var currentUserIdForBlocking: Int?
    var reachedEnd = false
    
    // additions
    private var maxId = Int(Int32.max)
    
    func fetchItems(refresh: Bool) -> Promise<[Genre]> {
        if refresh { maxId = Int(Int32.max) }
        guard !reachedEnd else { return Promise.value([]) }
        
        return Genre.fetchGenres().then { (result: [Genre]) -> Promise<[Genre]> in
            
            return .value(result)

        }
    }
    
}
