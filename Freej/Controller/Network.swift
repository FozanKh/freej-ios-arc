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
    let host = NetworkReachabilityManager(host: "https://crural-spare.000webhostapp.com/")
    
    func checkInternet() -> Bool {
        return host?.isReachable ?? false
    }
    
    static func signUpUser(_ kfupmID: String, _ firstName: String, _ lastName: String, _ bno: String) -> Bool {
        var signUpStatus: Bool = true
        let params =   ["BNo" : bno,
                        "FName" : firstName,
                        "LName" : lastName,
                        "KFUPMID" : kfupmID,
                        "Gender" : "M",
                        "Status" : "Unactivated"]
        let url = "http://crural-spare.000webhostapp.com/PostStudent.php"
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
            signUpStatus = response.result.isSuccess
        }
        return signUpStatus
    }
}

