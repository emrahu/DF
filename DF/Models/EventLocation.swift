//
//  EventLocation.swift
//  DragonFly
//
//  Created by Emrah Usar on 3/8/18.
//  Copyright © 2018 Usar Labs. All rights reserved.
//

import ObjectMapper

struct EventLocation:Mappable {
    var name:String?
    var address:String?
    var city:String?
    var state:String?
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        name    <- map["name"]
        address <- map["address"]
        city    <- map["city"]
        state   <- map["state"]
    }
    
    func toString()->String?{
        return "Address: \(name!)\n\(address!)\n\(city!), \(state!) "
    }
}
