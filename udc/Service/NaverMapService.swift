//
//  NaverMap.swift
//  udc
//
//  Created by 도로맥 on 2021/07/27.
//

import Foundation
import UIKit
import PromiseKit

extension NaverMap {
    
    
    static var FETCH_COUNT : Int{
        return 10
    }
    
    
    static func getAddressByLocation( latitude : Double , longitude : Double) -> Promise<NaverMap> {
    
        let params: Parameters = [
            "output" : "json",
            "coords" : "\(longitude),\(latitude)",
            "orders" : "roadaddr"
            ].filterNotNil()
        
        return AppService.NaverGET(endPoint: "/map-reversegeocode/v2/gc", params: params)
    }

    
}
