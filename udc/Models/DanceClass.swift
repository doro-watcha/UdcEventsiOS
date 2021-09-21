//
//  DanceClass.swift
//  udc
//
//  Created by 도로맥 on 2021/07/22.
//

import Foundation

final class DanceClass : Codable {
 
    var id : Int = 0

    var mainImgUrl : String
    
    var name : String? = nil
    
    var description :String? = nil
    
    var youtubeUrl : String? = nil
    
    var isMainClass : Bool? = false
    
    var status : String
    
    var date : String
    
    var startTime : String
    
    var level : Level
    
    var academy : Academy
    
    var genre : Genre
    
    //var subImgs : [String]? = nil

    var artist : Artist
    
    var ratingPoint : Float? = 0.0
    
    var ratingCount : Int? = 0


    
}
