//
//  Event.swift
//  DragonFly
//
//  Created by Emrah Usar on 3/8/18.
//  Copyright © 2018 Usar Labs. All rights reserved.
//

import Foundation
import ObjectMapper

struct Event: Mappable {
    var id:String?
    var name:String?
    var description:String?
    var images: [EventImage]?
    var location: EventLocation?
    var date: Date?
    var comments: [EventComment]?

    init(id:String, name:String, description:String, images:[EventImage]?, location:EventLocation, date:Date, comments:[EventComment]?) {
        self.id = id
        self.name = name
        self.description = description
        self.images = images
        self.location = location
        self.date = date
        self.comments = comments
    }
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        description <- map["description"]
        images      <- map["images"]
        location    <- map["location"]
        date        <- (map["date"], CustomDateTransform(dateString: "yyyy-MM-dd'T'HH:mm:ssZ"))
        comments    <- map["comments"]
    }
}

class CustomDateTransform: DateFormatterTransform {
    init(dateString format:String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format 
        super.init(dateFormatter: formatter)
    }
}



