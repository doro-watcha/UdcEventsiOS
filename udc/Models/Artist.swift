//
//  Artist.swift
//  udc
//
//  Created by 도로맥 on 2021/07/22.
//

import Foundation
import UIKit

final class Artist : Codable{
    
    var id : Int

    var name : String

    var team : String? = nil

    var instagramUrl : String? = nil

    var youtubeUrl : String? = nil

    var location : String? = nil

    var genre : String? = nil

    var avatarUrl : String? = nil
}
