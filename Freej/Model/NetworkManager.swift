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

enum RequestType: String {
	case student = "http://freejapp.com/FreejAppRequest/GetStudent.php"
	case announcement = "http://freejapp.com/FreejAppRequest/GetAnnouncements.php"
	case activityType = "http://freejapp.com/FreejAppRequest/GetActivityTypes.php"
	case activity = "http://freejapp.com/FreejAppRequest/GetActivities.php"
	case updateUserInfo = "http://freejapp.com/FreejAppRequest/UpdateUserInfo.php"
	case addAnnouncement = "http://freejapp.com/FreejAppRequest/PostAnnouncements.php"
	case deleteStudent = "http://freejapp.com/FreejAppRequest/DeleteStudent.php"
	case sendOTP = "http://freejapp.com/FreejAppRequest/SendOTP.php"
	case addStudent = "http://freejapp.com/FreejAppRequest/PostStudent.php"
    case whatsAppLink = "http://freejapp.com/FreejAppRequest/GetWhatsappURL.php"
	case addActivity = "http://freejapp.com/FreejAppRequest/PostActivity.php"
	case deleteActivity = "http://freejapp.com/FreejAppRequest/DeleteActivity.php"
}

struct NetworkManager {
	//MARK:- Internet Monitor
    static var monitor: NetworkReachabilityManager?
    static let internetStatusNName = Notification.Name("didChangeInternetStatus")
		
    static func setUpInternetStatusNotification() {
        monitor = NetworkReachabilityManager()
        monitor?.startListening()
        monitor?.listener = { status in
            NotificationCenter.default.post(name: Notification.Name("didChangeInternetStatus"), object: nil, userInfo: ["Status" : parseInternetStatus("\(status)")])
        }
    }
	
	//MARK:- Request Methods
	static func request(type: RequestType, params: [String : String]?, completion: @escaping (JSON?, Bool) -> ()) {
		Alamofire.request(type.rawValue, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
			let responseValue = response.result.value ?? nil
			let boolStatus = response.response?.statusCode == 201
			
			
			if(responseValue == nil) {completion(nil, boolStatus)}
			else {completion(JSON(responseValue!), boolStatus)}
		}
	}
	
	//MARK:- Misc. Methods
    static func parseInternetStatus(_ status: String) -> Bool {
        var boolStatus: Bool
        "\(status)".contains("not") ? (boolStatus = false) : (boolStatus = true)
        return boolStatus
    }
}
