//
//  User.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 23/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

class Student {
	static var userID: String?
	static var bno: String?
	static var fName: String?
	static var lName: String?
	static var kfupmID: String?
	static var gender: String?
	static var stat: String?
	
	static func assignAttributesAndSaveUser(json: JSON) {
		userID = json["UserID"].stringValue
		bno = json["BNo"].stringValue
		fName = json["FName"].stringValue
		lName = json["LName"].stringValue
		kfupmID = json["KFUPMID"].stringValue
		gender = json["Gender"].stringValue
		stat = json["Stat"].stringValue
		
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		
		let managedContext = appDelegate.persistentContainer.viewContext
		let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
		let student = NSManagedObject(entity: entity, insertInto: managedContext)
		student.setValue(userID, forKeyPath: "userID")
		student.setValue(bno, forKeyPath: "bno")
		student.setValue(fName, forKeyPath: "fName")
		student.setValue(lName, forKeyPath: "userID")
		student.setValue(kfupmID, forKeyPath: "kfupmID")
		student.setValue(gender, forKeyPath: "gender")
		student.setValue(stat, forKeyPath: "stat")
		
		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}
	
	static func clearAttributesAndDeleteUser() {
		userID = nil
		bno = nil
		fName = nil
		lName = nil
		kfupmID = nil
		gender = nil
		stat = nil
		
		//delete user
	}
}
