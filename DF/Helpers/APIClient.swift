//
//  APIClient.swift
//  DF
//
//  Created by Emrah Usar on 3/11/18.
//  Copyright © 2018 Usar Labs. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class APIClient {
    
    typealias GetEvent = Result<[Event]?, Bool, String?>
    typealias GetEventCompletion = (_ result:GetEvent)->Void
    
    static let apiUrlString = Constants.API.url
    static private var header: HTTPHeaders {
        let credentialData = "\(Constants.API.userName):\(Constants.API.password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        return ["Authorization":"Basic \(base64Credentials)"]
    }
    
    class func getEvents(completionHandler:@escaping GetEventCompletion) {
        Alamofire.request("\(apiUrlString)/events", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseJSON(queue: nil, options: .allowFragments) { (response) in
                
                switch response.result {
                case .success(let data):
                    if let mappedEvents = Mapper<Event>().mapArray(JSONObject: data){
                        completionHandler(.success(payload:mappedEvents, result:true))
                    } else {
                        completionHandler(.failure("Incorrect format"))
                    }
                case .failure(let error):
                    completionHandler(.failure(error.localizedDescription))
                }
        }
    }
    
    
    class func attendEvent(event:Event, isAttending:Bool ,completionHandler:@escaping(_ sucess:Bool, _ error:String?)->()) {
        let params:Parameters = ["coming":isAttending]
        Alamofire.request("\(apiUrlString)/events/\(event.id!)/status/", method: .put, parameters: params, encoding: JSONEncoding.default, headers: self.header)
            .validate()
            .responseJSON(queue: nil, options: .allowFragments) { (response) in
                switch response.result {
                case .success(_):
                    completionHandler(true, nil)
                    
                case .failure(let error):
                    completionHandler(false, error.localizedDescription)
                }
        }
    }
    
    
    class func eventImage(eventId:String, imageId:String, completionHandler:@escaping(_ image:UIImage)->()){
        
        Alamofire.request("\(apiUrlString)/events/\(eventId)/media/\(imageId)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseData(completionHandler: { (response) in
                switch response.result {
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        return
                    }
                    completionHandler(image)
                case .failure(let error):
                    print("Image loading request error: \(error.localizedDescription)")
                }
            })
    }
}
