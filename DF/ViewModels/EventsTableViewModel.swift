//
//  EventsViewModel.swift
//  DragonFly
//
//  Created by Emrah Usar on 3/8/18.
//  Copyright © 2018 Usar Labs. All rights reserved.
//
import UIKit
class EventsTableViewModel: NSObject {
    
    let title = "Events"
    let eventCellIdentifier:String = "Cell Event"
    var events = [Event]()
    
    func events(completionHandler:@escaping(_ success:Bool, _ error:String?)->()){
        APIClient.getEvents { [weak self] (result) in
            switch result {
            case .success(let payload, let result):
                guard let payload = payload else{ return }
                self?.events = payload
                completionHandler(result, nil)
            case .failure(let failure):
                completionHandler(false, failure!)
            }
        }
    }
    
    func eventImage(eventId:String, imageId:String?, completionHandler:@escaping(_ image:UIImage)->()){
        guard let imageId = imageId else { return }
        APIClient.eventImage(eventId: eventId, imageId: imageId) { (image) in
            completionHandler(image)
        }
    }
}
