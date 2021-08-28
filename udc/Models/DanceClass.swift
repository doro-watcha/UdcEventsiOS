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
    
    var academy : Academy? = nil
    
    var genre : Genre? = nil
    
    //var subImgs : [String]? = nil

    var artist : Artist? = nil
    
    var ratingPoint : Float? = 0.0
    
    var ratingCount : Int? = 0


    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case mainImgUrl = "mainImgUrl"
//        case description = "description"
//        case youtubeUrl = "youtubeUrl"
//        case isMainClass = "isMainClass"
//        case name = "name"
//        case status = "status"
//        case date = "date"
//        case startTime = "startTime"
//        case level = "level"
//        case target = "target"
//        case artistName = "artistName"
//        case artistProfileImgUrl = "artistProfileImgUrl"
//        case artistDescription = "artistDescription"
//        case artistInstagram = "artistInstagram"
//        case academy = "academy"
//        case genre = "genre"
//        case artist = "artist"
//    }

    
}
