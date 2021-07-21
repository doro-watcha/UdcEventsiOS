//
//  Event.swift
//  udc
//
//  Created by 도로맥 on 2021/07/11.
//

import Foundation


final class Event: Codable {
    
    
    var id : Int = 0
    
    var posterImgUrl : String = ""

    
    var _name: String?
    var name: String { return _name ?? "" }
    
    var _eventType : String?
    var eventType : String { return _eventType ?? ""}
    
    var _location : String?
    var location : String { return _location ?? ""}

    var _createdAt : String?
    var createdAt : String { return _createdAt ?? ""}
    
    var _status : String?
    var status : String { return _status ?? ""}
    
    var _subtitle : String?
    var subtitle : String { return _subtitle ?? ""}
    
    var _description : String?
    var description : String { return _description ?? ""}
    
    var _longitude : Double?
    var longitude : Double { return _longitude ?? 0.0}
    
    var _latitude : Double?
    var latitude : Double { return _latitude ?? 0.0}
    
    

    
}
