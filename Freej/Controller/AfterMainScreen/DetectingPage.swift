//
//  DetectingPage.swift
//  Freej
//
//  Created by khaled khamis on 09/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class DetectingPage: UITabBarController {

    static let getAmeenURL = "http://freejapp.com/FreejAppRequest/GetAmeen.php"
//    static let getActivityURL = "http://freejapp.com/FreejAppRequest/GetActivity.php"
    
//    static var activities : [Actitvities] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    static func getAmeen(userID: String, completion: @escaping (Bool) -> ()) {
//        let params = ["UserID" : userID]
//        Alamofire.request(getAmeenURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
//            completion(response.result.isSuccess)
//        }
//    }
    
//    static func getActivity(actid : Int){
//        Alamofire.request(getActivityURL, method: .post, parameters: ["AcTID" : actid], encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
//            if let value = response.result.value {
//
//                let json = JSON(value)
//                activities.removeAll()
//                for anItem in json.array! {
//                    activities.append(Actitvities(type: anItem["AcTID"].stringValue, title: anItem["Title"].stringValue, text: anItem["Descrp"].stringValue, time: anItem["SDate"].stringValue, status: anItem["Stat"].stringValue))
//                }
//                print("======================",activities.count)
//
//            }
//        }
//    }
    

}
