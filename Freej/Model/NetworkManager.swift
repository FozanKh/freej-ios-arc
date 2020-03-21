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
    static let signUpURL = "http://crural-spare.000webhostapp.com/PostStudent.php"
    static let sendOTP = "freejapp.com/FreejAppRequest/SendOTP.php"
	
    static var monitor: NetworkReachabilityManager?
    static let internetStatusNName = Notification.Name("didChangeInternetStatus")
    
    static func setUpInternetStatusNotification() {
        monitor = NetworkReachabilityManager()
        monitor?.startListening()
        monitor?.listener = { status in
            NotificationCenter.default.post(name: Notification.Name("didChangeInternetStatus"), object: nil, userInfo: ["Status" : parseInternetStatus("\(status)")])
        }
    }
    
    static func signUpUser(_ kfupmID: String, _ firstName: String, _ lastName: String, _ bno: String, completion: @escaping (Bool) -> ()) {
        let params =   ["BNo" : bno,
                        "FName" : firstName,
                        "LName" : lastName,
                        "KFUPMID" : kfupmID,
                        "Gender" : "M",
                        "Status" : "Unactivated"]
        
        Alamofire.request(signUpURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
            
            completion(response.result.isSuccess)
        }
    }
    
    static func isSignedUp(kfupmID: String, completion: @escaping (Bool) -> ()) {
        Alamofire.request(checkUserSignUpURL, method: .post, parameters: ["KFUPMID" : kfupmID], encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
            
            completion(response.result.isSuccess)
        }
    }
    
    static func parseInternetStatus(_ status: String) -> Bool {
        var boolStatus: Bool
        "\(status)".contains("not") ? (boolStatus = false) : (boolStatus = true)
        return boolStatus
    }
}
