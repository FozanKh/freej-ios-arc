//
//  Network.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 13/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import Network

class NetworkManager {
    static let checkUserSignUpURL = "https://crural-spare.000webhostapp.com/CheckUserSignUpStatus.php"
    static let singUpURL = "http://crural-spare.000webhostapp.com/PostStudent.php"
    
    static var monitor: NetworkReachabilityManager?
    static let name = Notification.Name("didChangeInternetStatus")
    
    static func setUpInternetStatusNotification() {
        monitor = NetworkReachabilityManager()
        monitor?.startListening()
        monitor?.listener = { status in
            NotificationCenter.default.post(name: Notification.Name("didChangeInternetStatus"), object: nil, userInfo: ["Status" : "\(status)"])
        }
    }
    
    static func signUpUser(_ kfupmID: String, _ firstName: String, _ lastName: String, _ bno: String, completion: @escaping (Bool) -> ()) {
        let params =   ["BNo" : bno,
                        "FName" : firstName,
                        "LName" : lastName,
                        "KFUPMID" : kfupmID,
                        "Gender" : "M",
                        "Status" : "Unactivated"]
        
        Alamofire.request(singUpURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
            
            completion(response.result.isSuccess)
        }
    }
    
    static func isSignedUp(kfupmID: String, completion: @escaping (Bool) -> ()) {
        Alamofire.request(checkUserSignUpURL, method: .post, parameters: ["KFUPMID" : kfupmID], encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
            
            completion(response.result.isSuccess)
        }
    }
}
