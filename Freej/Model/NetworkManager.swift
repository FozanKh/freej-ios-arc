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
	static let getStudentURL = "http://freejapp.com/FreejAppRequest/GetStudent.php"
    static let signUpURL = "http://freejapp.com/FreejAppRequest/PostStudent.php"
    static let sendOTPURL = "http://freejapp.com/FreejAppRequest/SendOTP.php"
	static let getAnnouncementsURL = "http://freejapp.com/FreejAppRequest/GetAnnouncements.php"
    static let postAnnouncementURL = "http://freejapp.com/FreejAppRequest/PostAnnouncements.php"
    static let getAmeenURL = "http://freejapp.com/FreejAppRequest/GetAmeen.php"
    static let deleteStudentURL = "http://freejapp.com/FreejAppRequest/DeleteStudent.php"
	static let updateUserInfoURL = "http://freejapp.com/FreejAppRequest/UpdateUserInfo.php"
	
    static var monitor: NetworkReachabilityManager?
    static let internetStatusNName = Notification.Name("didChangeInternetStatus")
		
    static func setUpInternetStatusNotification() {
        monitor = NetworkReachabilityManager()
        monitor?.startListening()
        monitor?.listener = { status in
            NotificationCenter.default.post(name: Notification.Name("didChangeInternetStatus"), object: nil, userInfo: ["Status" : parseInternetStatus("\(status)")])
        }
    }
	
	static func updateUserInfo(kfupmID: String, fName: String, lName: String, bno: String, completion: @escaping (Bool) -> ()) {
		let params = ["KFUPMID" : kfupmID,
					  "FName" : fName,
					  "LName" : lName,
					  "BNo" : bno]
		Alamofire.request(updateUserInfoURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
			let statusCode = response.response?.statusCode
			statusCode == 201 ? completion(true) : completion(false)
		}
	}
	
	static func deleteStudent(kfupmID: String, completion: @escaping (Bool) -> ()) {
		let params = ["KFUPMID" : kfupmID]
		Alamofire.request(deleteStudentURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
			let statusCode = response.response?.statusCode
			statusCode == 201 ? completion(true) : completion(false)
		}
	}
    static func getAmeen(userID: String, completion: @escaping (Bool) -> ()) {
        let params = ["UserID" : userID]
        Alamofire.request(getAmeenURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
            completion(response.result.isSuccess)
        }
    }
    
	static func getStudent(kfupmID: String, completion: @escaping (Student?) -> ()) {
		let params = ["KFUPMID" : kfupmID]
		
		Alamofire.request(getStudentURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
			let responseValue = response.result.value ?? nil
			let jsonResponse: JSON?
			
			responseValue == nil ? (jsonResponse = nil) : (jsonResponse = JSON(responseValue!)[0])
			
			let createdStudent = DataModel.createStudent(fromJSON: jsonResponse, isSignuedDB: true)
			completion(createdStudent)
		}
	}
	
	static func sendOTP(toEmail: String, otp: String, completion: @escaping (Bool) -> ()) {
//		let params = ["to" : "abdulelahhajjar@gmail.com", "otp" : otp]
//		Alamofire.request(sendOTPURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
//			response.response?.statusCode ?? 500 == 201 ? completion(true) : completion(false)
//		}
		print(otp)
	}
    
    static func signUpUser(_ kfupmID: String, _ firstName: String, _ lastName: String, _ bno: String, completion: @escaping (Student?) -> ()) {
        let params =   ["BNo" : bno,
                        "FName" : firstName,
                        "LName" : lastName,
                        "KFUPMID" : kfupmID,
                        "Gender" : "M",
                        "Status" : "Unactivated"]
        
        Alamofire.request(signUpURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
			getStudent(kfupmID: kfupmID) { (studentDB) in
				completion(studentDB)
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
//            print(response)
            completion(response.result.isSuccess)
        }
    }
    
    static func getAnnouncements(completion: @escaping (JSON?) -> ()) {
        Alamofire.request(getAnnouncementsURL, method: .post, parameters: nil, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
            let responseValue = response.result.value ?? nil
            responseValue == nil ? completion(nil) : completion(JSON(responseValue!))
        }
    }
    
    static func parseInternetStatus(_ status: String) -> Bool {
        var boolStatus: Bool
        "\(status)".contains("not") ? (boolStatus = false) : (boolStatus = true)
        return boolStatus
    }
}
