//
//  Broadcast.swift
//  udc
//
//  Created by 도로맥 on 2021/07/29.
//

import Foundation
import RxSwift

class Broadcast{
    
    // MARK: - API is called for update UI
    
    /**
    Event - Profile updated, value means id of user
    */
    static let EVENT_DATE_PICK_BROADCAST = PublishSubject<String>()
    
    
}
