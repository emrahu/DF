//
//  Constants.swift
//  DragonFly
//
//  Created by Emrah Usar on 3/8/18.
//  Copyright © 2018 Usar Labs. All rights reserved.
//

import Foundation
import UIKit

enum Result<Payload, Success, Failure>{
    case success(payload:Payload, result:Success)
    case failure(Failure?)
}

class Constants {
    
    static let shared = Constants()
    struct API {
        static let url:String = "http://api.cloudservice.com"
        static let userName = "emeril"
        static let password = "evalpass"
    }
}

extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    
    func displayAlert(vc:UIViewController, title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
    }
}
