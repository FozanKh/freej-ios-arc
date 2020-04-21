//
//  User.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 23/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

@objc(Student)
class Student: NSManagedObject {
	static func getStudentDB(kfupmID: String, completion: @escaping (Student?) -> ()) {
		NetworkManager.jsonRequest(type: .student, params: ["KFUPMID" : kfupmID]) { (stuJSON) in
			if(stuJSON != nil) {completion(DataModel.createStudent(fromJSON: JSON(stuJSON!)[0], isSignuedDB: true))}
			else {completion(nil)}
		}
	}
	
	func deleteStudentRecord(completion: @escaping (Bool) -> ()) {
		NetworkManager.boolRequest(type: .deleteStudent, params: ["KFUPMID" : kfupmID!]) { (success) in
			completion(success)
		}
	}
	
	func signUp(completion: @escaping (JSON?) -> ()) {
		let params = ["KFUPMID" : kfupmID!, "FName" : fName!, "LName" : lName!, "BNo" : bno!, "Gender" : "M", "Stat" : "Active"]
		
		NetworkManager.boolRequest(type: .addStudent, params: params) { (didSignUp) in
			if(didSignUp) {
				NetworkManager.jsonRequest(type: .student, params: ["KFUPMID" : self.kfupmID!]) { (dbStuJSON) in
					completion(dbStuJSON)
				}
			}
			else {
				completion(nil)
			}
		}
	}
}
