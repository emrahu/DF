//
//  EventDetailsViewModel.swift
//  DragonFly
//
//  Created by Emrah Usar on 3/8/18.
//  Copyright © 2018 Usar Labs. All rights reserved.
//

import UIKit
import Alamofire

class EventDetailsViewModel: NSObject{
    
    enum EventState:String {
        case attending = "Attending"
        case notAttending = "Not attending"
        case unknown
    }
    
    let userDefaults = UserDefaults.standard
    let commentCellIdentifier = "Cell Comment"
    let dateFormatter = DateFormatter()
    let sectionHeader = "COMMENTS"
    let imageViewCellIdentifier = "Cell Image"
    var imageToShare:UIImage? = UIImage()
    var eventDate:String? {
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        let eventDate = dateFormatter.string(from: event!.date!)
        return eventDate
    }
    
    var eventState:EventState!
    
    var emailBody: String? {
        var emailBody = event.description!
        emailBody += "<br /><br >"
        emailBody += "Date: \(eventDate!)"
        emailBody += "<br /><br >"
        emailBody += event.location!.toString()!
        return emailBody
    }
    
    var event:Event!
    init(event:Event) {
        self.event = event
    }
    
    func attendEvent(attend:Bool, completionHandler:@escaping(_ sucess:Bool, _ error:String?)->()){
        APIClient.attendEvent(event: event, isAttending: attend) { (success, error) in
            if success {
                completionHandler(true, nil)
            } else {
                completionHandler(false, error!)
            }
        }
    }
    
    func eventImage(eventId:String, imageId:String?, completionHandler:@escaping(_ image:UIImage)->()){
        guard let imageId = imageId else { return }
        APIClient.eventImage(eventId: eventId, imageId: imageId) { (image) in
            self.imageToShare = image
            completionHandler(image)
        }
    }
    
    func getEvent() -> String? {
        let eventId = userDefaults.object(forKey: self.event.id!) as? String
        if eventId != nil {
            return eventId
        }
        return nil
    }
    
    func updateEvent(){
        if getEvent() == nil {
            userDefaults.set(self.event.id!, forKey: self.event.id!)
        } else {
            userDefaults.removeObject(forKey: self.event.id!)
        }
        userDefaults.synchronize()
    }
}
