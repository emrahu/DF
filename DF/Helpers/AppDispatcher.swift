//
//  AppCoordinator.swift
//  DragonFly
//
//  Created by Emrah Usar on 3/8/18.
//  Copyright © 2018 Usar Labs. All rights reserved.
//

import UIKit
import Alamofire

class AppDispatcher {
    var window: UIWindow?
    let network = NetworkManager.shared
    init(window: UIWindow?) {
        self.window = window
        self.window?.makeKeyAndVisible()
        network.startObservingConnectivity()
    }
    
    func dispatch() -> (Void) {
        let eventsViewController = EventsTableViewController()
        let navigationController = UINavigationController(rootViewController: eventsViewController)
        self.window?.rootViewController = navigationController
    }
}
