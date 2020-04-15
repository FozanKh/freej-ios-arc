//
//  DataModel.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 23/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

class DataModel {
	static var currentUser: Student?
	
	static let appDelegate = UIApplication.shared.delegate as! AppDelegate
	static let managedContext = appDelegate.persistentContainer.viewContext
	
	static func setSignedUpUser(userJSON: JSON, saveToPersistent: Bool, isSignedUpDB: Bool) {
		//Set Persistant current user
		let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
		let student = NSManagedObject(entity: entity, insertInto: managedContext)
		student.setValue(userJSON["UserID"].stringValue, forKeyPath: "userID")
		student.setValue(userJSON["BNo"].stringValue, forKeyPath: "bno")
		student.setValue(userJSON["FName"].stringValue, forKeyPath: "fName")
		student.setValue(userJSON["LName"].stringValue, forKeyPath: "lName")
		student.setValue(userJSON["KFUPMID"].stringValue, forKeyPath: "kfupmID")
		student.setValue(userJSON["Gender"].stringValue, forKeyPath: "gender")
		student.setValue(userJSON["Stat"].stringValue, forKeyPath: "stat")
		
		//Set Temporary (this session) currentUser
		currentUser = student as? Student
		
		if(saveToPersistent) {
			let _ = saveCurrentUserToPersistent()
		}
	}
	
	static func setCurrentStudent(student: Student, saveToPersistent: Bool) {
		currentUser = student
		if(saveToPersistent) {
			let _ = saveCurrentUserToPersistent()
		}
	}
	
	//This method does not save in the persistent model, it only instantiates a student object
	static func createStudent(fromJSON: JSON?, isSignuedDB: Bool) -> Student? {
		if(fromJSON != nil) {
			let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
			let student = NSManagedObject(entity: entity, insertInto: managedContext)
			student.setValue(fromJSON!["UserID"].stringValue, forKeyPath: "userID")
			student.setValue(fromJSON!["BNo"].stringValue, forKeyPath: "bno")
			student.setValue(fromJSON!["FName"].stringValue, forKeyPath: "fName")
			student.setValue(fromJSON!["LName"].stringValue, forKeyPath: "lName")
			student.setValue(fromJSON!["KFUPMID"].stringValue, forKeyPath: "kfupmID")
			student.setValue(fromJSON!["Gender"].stringValue, forKeyPath: "gender")
			student.setValue(fromJSON!["Stat"].stringValue, forKeyPath: "stat")
			student.setValue(fromJSON!["IsAmeen"].stringValue, forKeyPath: "isAmeen")
			student.setValue(String(isSignuedDB), forKeyPath: "isSignedUpDB")
			return student as? Student
		}
		return nil
	}
	
	static func setUnSignedUpUser(kfupmID: String, saveToPersistent: Bool, isSignedUpDB: Bool) {
		let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
		let student = NSManagedObject(entity: entity, insertInto: managedContext)
		student.setValue(kfupmID, forKeyPath: "kfupmID")
		
		currentUser = student as? Student
		
		if(saveToPersistent) {
			let _ = saveCurrentUserToPersistent()
		}
	}
	
	static func userIsSignedUp() -> Bool {
		var userIsSignedUp: Bool
		currentUser?.userID == nil ? (userIsSignedUp = false) : (userIsSignedUp = true)
		return userIsSignedUp
	}
	
	static func saveCurrentUserToPersistent() -> Bool {
		if(currentUser != nil) {
			do {
				try managedContext.save()
				return true
			} catch let error as NSError {
				print("Could not save. \(error), \(error.userInfo)")
				return false
			}
		}
		return false
	}
	
	static func clearCurrentUser() {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		
		let managedContext = appDelegate.persistentContainer.viewContext
		let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Student"))
		do {
			try managedContext.execute(DelAllReqVar)
		}
		catch {
			print(error)
		}
		
		//Remove Temporary (this session) currentUser
		currentUser = nil
	}
}
