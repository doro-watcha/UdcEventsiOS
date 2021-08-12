//
//  ClassDate.swift
//  udc
//
//  Created by 도로맥 on 2021/08/12.
//

import Foundation
final class ClassDate : Codable{
    
    init(day: Int, date :String, dateInt :Int ) {
        self.day = day
        self.date = date
        self.dateInt = dateInt
    }
    
    var day : Int
    
    var date : String
    
    var dateInt : Int

    
}

