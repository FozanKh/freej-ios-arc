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

class NetworkManager {
    static let checkUserSignUpURL = "http://freejapp.com/FreejAppRequest/CheckUserSignUpStatus.php"
    static let signUpURL = "http://freejapp.com/FreejAppRequest/PostStudent.php"
    static let sendOTPURL = "http://freejapp.com/FreejAppRequest/SendOTP.php"
	
    static var monitor: NetworkReachabilityManager?
    static let internetStatusNName = Notification.Name("didChangeInternetStatus")
    
    static func setUpInternetStatusNotification() {
        monitor = NetworkReachabilityManager()
        monitor?.startListening()
        monitor?.listener = { status in
            NotificationCenter.default.post(name: Notification.Name("didChangeInternetStatus"), object: nil, userInfo: ["Status" : parseInternetStatus("\(status)")])
        }
    }
	
	static func isSignedUp(kfupmID: String, completion: @escaping (Bool) -> ()) {
		let params = ["KFUPMID" : kfupmID]
		Alamofire.request(checkUserSignUpURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
			completion(response.result.isSuccess)
		}
	}
	
	static func sendOTP(toEmail: String, otp: String, completion: @escaping (Bool) -> ()) {
		let params = ["to" : "abdulelahhajjar@gmail.com", "otp" : otp]
		Alamofire.request(sendOTPURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
			response.response?.statusCode ?? 500 == 201 ? completion(true) : completion(false)
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
            print(response)
            completion(response.result.isSuccess)
        }
    }
    
    static func parseInternetStatus(_ status: String) -> Bool {
        var boolStatus: Bool
        "\(status)".contains("not") ? (boolStatus = false) : (boolStatus = true)
        return boolStatus
    }
}
