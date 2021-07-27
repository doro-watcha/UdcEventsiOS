//
//  NaverMap.swift
//  udc
//
//  Created by 도로맥 on 2021/07/27.
//

import Foundation
import UIKit


final class Status : Codable {

    var code : Int? = 0

    var name : String? = ""

    var message : String? = ""

}


final class Code : Codable {

    var id : String? = ""


    var type : String? = ""

    var mappingId : String? = ""
}


final class Area : Codable {
    var name : String? = ""
}

final class Region : Codable {

    var area0 : Area?


    var area1 : Area?


    var area2 : Area?


    var area3 : Area?


    var area4 : Area?
}

final class Land : Codable {


    var type : String? = ""


    var number1 : String? = ""


    var number2 : String? = ""


    var name : String? = ""
}


final class Result : Codable {

    var name : String? = ""


    var code : Code?


    var region : Region?


    var land : Land?

}



final class Meta : Codable{

    var totalCount : Int? = 0


    var page : Int? = 0

    var count : Int? = 0
}

final class AddressElement :Codable {

    var types : [String]?

    var longName : String?

    var shortName : String?

    var code : String?
}


final class Address :Codable {

  
    var roadAddress : String? = ""


    var jibunAddress : String? = ""


    var englishAddress : String? = ""


    var addresses : [AddressElement]?


    var x : String?


    var y : String?


    var distance : Float?
}



final class NaverMap : Codable{

    var status : Status?
    var results : [Result]?
}
