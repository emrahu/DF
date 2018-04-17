//
//  NetworkManager.swift
//  DragonFly
//
//  Created by Emrah Usar on 3/8/18.
//  Copyright © 2018 Usar Labs. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let NetworkReachabilityChanged = NSNotification.Name("NetworkReachabilityChanged")
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    func startObservingConnectivity(){
        reachabilityManager?.listener = { status in
            
            switch status {
            case .reachable(NetworkReachabilityManager.ConnectionType.ethernetOrWiFi):
                self.handleConnection(reachable:true)
                
            case .reachable(NetworkReachabilityManager.ConnectionType.wwan):
                self.handleConnection(reachable:true)
                
            case .notReachable:
                
                self.handleConnection(reachable: false)
            case .unknown:
                print("network unknown")
            }
        }
        reachabilityManager?.startListening()
    }
    
    func handleConnection(reachable:Bool){
        NotificationCenter.default.post(name: NetworkReachabilityChanged, object: nil, userInfo: ["reachabilityStatus" : reachable])
    }
}
