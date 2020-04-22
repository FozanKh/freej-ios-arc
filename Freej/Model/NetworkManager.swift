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

enum RequestType {
	case student
	case announcement
	case activityType
	case activity
	case updateUserInfo
	case addAnnouncement
	case deleteStudent
	case sendOTP
	case addStudent
    case whatsAppLink
}

struct NetworkManager {
	static let getStudentURL = "http://freejapp.com/FreejAppRequest/GetStudent.php"
    static let signUpURL = "http://freejapp.com/FreejAppRequest/PostStudent.php"
    static let sendOTPURL = "http://freejapp.com/FreejAppRequest/SendOTP.php"
	static let getAnnouncementsURL = "http://freejapp.com/FreejAppRequest/GetAnnouncements.php"
    static let postAnnouncementURL = "http://freejapp.com/FreejAppRequest/PostAnnouncements.php"
    static let deleteStudentURL = "http://freejapp.com/FreejAppRequest/DeleteStudent.php"
	static let updateUserInfoURL = "http://freejapp.com/FreejAppRequest/UpdateUserInfo.php"
	static let getActivityTypesURL = "http://freejapp.com/FreejAppRequest/GetActivityTypes.php"
	static let getActivitiesURL = "http://freejapp.com/FreejAppRequest/GetActivities.php"
    static let getWhatsappURL = "http://freejapp.com/FreejAppRequest/GetWhatsappURL.php"
	
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
	static func jsonRequest(type: RequestType, params: [String : String]?, responseJSON: @escaping (JSON?) -> ()) {
		Alamofire.request(url(forType: type), method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).responseJSON { (response) in
			let responseValue = response.result.value ?? nil
			
			if(responseValue == nil) {responseJSON(nil)}
			else {responseJSON(JSON(responseValue!))}
		}
	}
	
	static func boolRequest(type: RequestType, params: [String : String]?, responseBool: @escaping (Bool) -> ()) {
		Alamofire.request(url(forType: type), method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
			let statusCode = response.response?.statusCode
			statusCode == 201 ? responseBool(true) : responseBool(false)
		}
	}
	
	static func url(forType: RequestType) -> String {
		switch forType {
		case .student:
			return getStudentURL
		case .announcement:
			return getAnnouncementsURL
		case .activityType:
			return getActivityTypesURL
		case .activity:
			return getActivitiesURL
		case .updateUserInfo:
			return updateUserInfoURL
		case .addAnnouncement:
			return postAnnouncementURL
		case .deleteStudent:
			return deleteStudentURL
		case .sendOTP:
			return sendOTPURL
		case .addStudent:
			return signUpURL
        case .whatsAppLink:
            return getWhatsappURL
		}
	}

	//MARK:- Misc. Methods
    static func parseInternetStatus(_ status: String) -> Bool {
        var boolStatus: Bool
        "\(status)".contains("not") ? (boolStatus = false) : (boolStatus = true)
        return boolStatus
    }
}
