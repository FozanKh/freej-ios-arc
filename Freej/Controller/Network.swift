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
    let manager = NetworkReachabilityManager(host: "https://crural-spare.000webhostapp.com/")
    
    func hasInternet() -> Bool {
        return manager?.isReachable ?? false
    }
}

//Alamofire.request("https://crural-spare.000webhostapp.com/WelcomeScreenRequestBuildings.php", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//                if(response.result.isSuccess) {
//                    print(JSON(response.result.value!))
//            }
//        }