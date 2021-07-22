//
//  DanceClass.swift
//  udc
//
//  Created by 도로맥 on 2021/07/22.
//

import Foundation

final class DanceClass : Codable {
    
    init() {
        
        id = 1
        posterImgUrl = "https://udc-files.s3.amazonaws.com/event/%EB%85%B8%EB%93%A4%EC%84%AC/20210519_193326_1625589034050.jpg"
        classType = "zxcv"
        title = "Ji YOung Class"
    }
    
    
 
    var id : Int = 0


    var posterImgUrl : String


    var artist : Artist? = nil


    var description :String? = nil


    var career : String? = nil


    var youtubeUrl : String? = nil

   
    var classType : String


    var isMainClass : Bool? = false


    var title : String

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case posterImgUrl = "posterImgUrl"
        case description = "description"
        case career = "career"
        case youtubeUrl = "youtubeUrl"
        case classType = "classType"
        case isMainClass = "isMainClass"
        case title = "title"
    }

    
}
