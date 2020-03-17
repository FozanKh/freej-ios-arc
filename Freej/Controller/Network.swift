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


class Network {
    static let host = NetworkReachabilityManager(host: "https://crural-spare.000webhostapp.com/")

    static let checkUserSignUpURL = "https://crural-spare.000webhostapp.com/CheckUserSignUpStatus.php"
    static let singUpURL = "http://crural-spare.000webhostapp.com/PostStudent.php"
    
    static func checkInternet() -> Bool {
        return host?.isReachable ?? false
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
            response.response?.statusCode ?? 404 == 404 ? completion(false) : completion(true)
        }
    }
}
