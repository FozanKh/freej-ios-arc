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
	
    static var monitor: NetworkReachabilityManager?
    static let internetStatusNName = Notification.Name("didChangeInternetStatus")
		
    static func setUpInternetStatusNotification() {
        monitor = NetworkReachabilityManager()
        monitor?.startListening()
        monitor?.listener = { status in
            NotificationCenter.default.post(name: Notification.Name("didChangeInternetStatus"), object: nil, userInfo: ["Status" : parseInternetStatus("\(status)")])
        }
    }
	
	static func jsonRequest(type: RequestType, params: [String : String]?, responseJSON: @escaping (JSON?) -> ()) {
		Alamofire.request(url(forType: type), method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).responseJSON { (response) in
			let responseValue = response.result.value ?? nil
			
			if(responseValue == nil) {responseJSON(nil)}
			else {responseJSON(JSON(responseValue!))}
		}
	}
	
	static func boolRequest(type: RequestType, params: [String : String]?, responseBool: @escaping (Bool?) -> ()) {
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
		}
	}
	
//	static func updateUserInfo(kfupmID: String, fName: String, lName: String, bno: String, completion: @escaping (Bool) -> ()) {
//		let params = ["KFUPMID" : kfupmID,
//					  "FName" : fName,
//					  "LName" : lName,
//					  "BNo" : bno]
//		Alamofire.request(updateUserInfoURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
//			let statusCode = response.response?.statusCode
//			statusCode == 201 ? completion(true) : completion(false)
//		}
//	}
//	
	static func deleteStudent(kfupmID: String, completion: @escaping (Bool) -> ()) {
		let params = ["KFUPMID" : kfupmID]
		Alamofire.request(deleteStudentURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
			let statusCode = response.response?.statusCode
			statusCode == 201 ? completion(true) : completion(false)
		}
	}
    
	static func sendOTP(toEmail: String, otp: String, completion: @escaping (Bool) -> ()) {
//		let params = ["to" : "abdulelahhajjar@gmail.com", "otp" : otp]
//		Alamofire.request(sendOTPURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
//			response.response?.statusCode ?? 500 == 201 ? completion(true) : completion(false)
//		}
		print(otp)
	}
    
    static func signUpUser(_ kfupmID: String, _ firstName: String, _ lastName: String, _ bno: String, completion: @escaping (JSON?) -> ()) {
        let params =   ["BNo" : bno,
                        "FName" : firstName,
                        "LName" : lastName,
                        "KFUPMID" : kfupmID,
                        "Gender" : "M",
                        "Status" : "Unactivated"]
        
        Alamofire.request(signUpURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
			jsonRequest(type: .student, params: ["KFUPMID" : kfupmID]) { (studentJSON) in
				completion(studentJSON)
			}
        }
    }
    
    static func postAnnouncement(_ anTID: String, _ userID: String, _ title: String, _ descrp: String, completion: @escaping (Bool) -> ()) {
        let params =   ["AnTID" : anTID,
                        "UserID" : userID,
                        "Title" : title,
                        "Descrp" : descrp,
                        "SDate" : "2020-20-02",
                        "Stat" : "Activated"]
        Alamofire.request(postAnnouncementURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
            completion(response.result.isSuccess)
        }
    }
    
    static func parseInternetStatus(_ status: String) -> Bool {
        var boolStatus: Bool
        "\(status)".contains("not") ? (boolStatus = false) : (boolStatus = true)
        return boolStatus
    }
}
