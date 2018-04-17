//
//  EventComment.swift
//  DragonFly
//
//  Created by Emrah Usar on 3/8/18.
//  Copyright © 2018 Usar Labs. All rights reserved.
//

import ObjectMapper

struct EventComment:Mappable {

    var from:String?
    var text:String?

    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        from    <- map["from"]
        text    <- map["text"]
    }
}
