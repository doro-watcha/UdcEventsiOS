//
//  LogHelper.swift
//  udc
//
//  Created by 도로맥 on 2021/05/27.
//

import Foundation

func debugE(_ msg : Any...){
    #if DEBUG
    if msg.count == 0{
        print("🧩",msg,"🧩")
    }else{
        var msgs = ""
        for i in msg{
            msgs += "\(i) "
        }
        print("🧩",msgs,"🧩")
    }
    #endif
}
