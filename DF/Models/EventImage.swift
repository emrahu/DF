//
//  EventImage.swift
//  DragonFly
//
//  Created by Emrah Usar on 3/8/18.
//  Copyright © 2018 Usar Labs. All rights reserved.
//

import ObjectMapper
struct EventImage:Mappable {
    var id:String?
    var caption:String?
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        caption <- map["caption"]
    }
}
