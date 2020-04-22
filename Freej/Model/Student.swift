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
	
	init(userID: String, bno: String, fName: String, lName: String, kfupmID: String, gender: String, stat: String) {
		let managedContext = DataModel.managedContext
		super.init(entity: NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!, insertInto: managedContext)
		self.userID = userID
		self.bno = bno
		self.fName = fName
		self.lName = lName
		self.kfupmID = kfupmID
		self.gender = gender
		self.stat = stat
	}
	
	override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
		super.init(entity: entity, insertInto: context)
	}
	
	init() {
		let managedContext = DataModel.managedContext
		super.init(entity: NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!, insertInto: managedContext)
	}
	
	static func getStudentDB(kfupmID: String, completion: @escaping (Student?) -> ()) {
		NetworkManager.jsonRequest(type: .student, params: ["KFUPMID" : kfupmID]) { (stuJSON) in
			if(stuJSON != nil) {completion(Student.createStudent(fromJSON: JSON(stuJSON!)[0], isSignuedDB: true))}
			else {completion(nil)}
		}
	}
	
	func deleteStudentRecord(completion: @escaping (Bool) -> ()) {
		NetworkManager.boolRequest(type: .deleteStudent, params: ["KFUPMID" : kfupmID!]) { (success) in
			completion(success)
		}
	}
	
	func isSignedUp() -> Bool {
		var userIsSignedUp: Bool
		userID == nil ? (userIsSignedUp = false) : (userIsSignedUp = true)
		return userIsSignedUp
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
	
	static func createStudent(fromJSON: JSON, isSignuedDB: Bool) -> Student {
		let entity = NSEntityDescription.entity(forEntityName: "Student", in: DataModel.managedContext)!
		let student = NSManagedObject(entity: entity, insertInto: DataModel.managedContext)
		student.setValue(fromJSON["UserID"].stringValue, forKeyPath: "userID")
		student.setValue(fromJSON["BNo"].stringValue, forKeyPath: "bno")
		student.setValue(fromJSON["FName"].stringValue, forKeyPath: "fName")
		student.setValue(fromJSON["LName"].stringValue, forKeyPath: "lName")
		student.setValue(fromJSON["KFUPMID"].stringValue, forKeyPath: "kfupmID")
		student.setValue(fromJSON["Gender"].stringValue, forKeyPath: "gender")
		student.setValue(fromJSON["Stat"].stringValue, forKeyPath: "stat")
		student.setValue(fromJSON["IsAmeen"].boolValue, forKeyPath: "isAmeen")
		student.setValue(isSignuedDB, forKeyPath: "isSignedUpDB")
		print(fromJSON)
		return student as! Student
	}
}
