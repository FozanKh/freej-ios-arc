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
import CoreData

class NetworkManager {
    static let checkUserSignUpURL = "http://freejapp.com/FreejAppRequest/CheckUserSignUpStatus.php"
	static let getStudentURL = "http://freejapp.com/FreejAppRequest/GetStudent.php"
    static let signUpURL = "http://freejapp.com/FreejAppRequest/PostStudent.php"
    static let sendOTPURL = "http://freejapp.com/FreejAppRequest/SendOTP.php"
	
    static var monitor: NetworkReachabilityManager?
    static let internetStatusNName = Notification.Name("didChangeInternetStatus")
	
	static var currentUser: Student?
	
	static func test(json: JSON) {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		let managedContext = appDelegate.persistentContainer.viewContext
		let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
		let student = NSManagedObject(entity: entity, insertInto: managedContext)
		student.setValue(json["UserID"].stringValue, forKeyPath: "userID")
		student.setValue(json["BNo"].stringValue, forKeyPath: "bno")
		student.setValue(json["FName"].stringValue, forKeyPath: "fName")
		student.setValue(json["LName"].stringValue, forKeyPath: "lName")
		student.setValue(json["KFUPMID"].stringValue, forKeyPath: "kfupmID")
		student.setValue(json["Gender"].stringValue, forKeyPath: "gender")
		student.setValue(json["Stat"].stringValue, forKeyPath: "stat")
		
		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}
	
    static func setUpInternetStatusNotification() {
        monitor = NetworkReachabilityManager()
        monitor?.startListening()
        monitor?.listener = { status in
            NotificationCenter.default.post(name: Notification.Name("didChangeInternetStatus"), object: nil, userInfo: ["Status" : parseInternetStatus("\(status)")])
        }
    }
	
	static func getStudent(kfupmID: String, completion: @escaping (JSON, Bool) -> ()) {
		let params = ["KFUPMID" : kfupmID]
		Alamofire.request(getStudentURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
			let requestStatus = response.result.isSuccess
			let userInfo = JSON(response.result.value ?? nil!)
			completion(userInfo, requestStatus)
		}
	}
	
	static func isSignedUp(kfupmID: String, completion: @escaping (Bool) -> ()) {
		let params = ["KFUPMID" : kfupmID]
		Alamofire.request(checkUserSignUpURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
			completion(response.result.isSuccess)
		}
	}
	
	static func sendOTP(toEmail: String, otp: String, completion: @escaping (Bool) -> ()) {
//		let params = ["to" : "abdulelahhajjar@gmail.com", "otp" : otp]
//		Alamofire.request(sendOTPURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
//			response.response?.statusCode ?? 500 == 201 ? completion(true) : completion(false)
//		}
		print(otp)
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
