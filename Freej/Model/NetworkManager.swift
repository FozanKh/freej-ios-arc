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
	case sessionData =		"http://freejapp.com/FreejAppRequest/iOSApp/GetSessionData.php"

	case getUser =			"http://freejapp.com/FreejAppRequest/iOSApp/GetStudent.php"
	case addUser =			"http://freejapp.com/FreejAppRequest/iOSApp/PostStudent.php"
	case updateUser =		"http://freejapp.com/FreejAppRequest/iOSApp/UpdateUser.php"
	case deleteUser =		"http://freejapp.com/FreejAppRequest/iOSApp/DeleteStudent.php"
	
	case sendOTP =			"http://freejapp.com/FreejAppRequest/iOSApp/SendOTP.php"

	case addActivity =		"http://freejapp.com/FreejAppRequest/iOSApp/PostActivity.php"
	case deleteActivity =	"http://freejapp.com/FreejAppRequest/iOSApp/DeleteActivity.php"

	case addAnnouncement = 	"http://freejapp.com/FreejAppRequest/iOSApp/PostAnnouncements.php"
}

struct NetworkManager {
	//MARK:- Internet Monitor
    static var monitor: NetworkReachabilityManager?
    static let internetStatusNName = Notification.Name("didChangeInternetStatus")
		
    static func setUpInternetStatusNotification() {
        monitor = NetworkReachabilityManager()
		monitor?.listener = { status in
			NotificationCenter.default.post(name: Notification.Name("didChangeInternetStatus"), object: nil, userInfo: ["Status" : parseInternetStatus("\(status)")])
		}
        monitor?.startListening()
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
