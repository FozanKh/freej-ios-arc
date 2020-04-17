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

protocol DataModelProtocol {
	func userHasValidated()
}

class DataModel {
	static var currentUser: Student?
	
	static let appDelegate = UIApplication.shared.delegate as! AppDelegate
	static let managedContext = appDelegate.persistentContainer.viewContext
	
	static var dataModelDelegate: DataModelProtocol?
	
	static func setCurrentStudent(student: Student, saveToPersistent: Bool) {
		currentUser = student
		if(saveToPersistent) {
			let _ = saveCurrentUserToPersistent()
		}
	}
	
	//This method does not save in the persistent model, it only instantiates a student object
	static func createStudent(fromJSON: JSON, isSignuedDB: Bool) -> Student {
		let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
		let student = NSManagedObject(entity: entity, insertInto: managedContext)
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
	
	static func instantiateEmptyStudent() {
		let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
		let student = NSManagedObject(entity: entity, insertInto: managedContext)
		currentUser = student as? Student
	}
	
	static func userIsSignedUp() -> Bool {
		var userIsSignedUp: Bool
		currentUser?.userID == nil ? (userIsSignedUp = false) : (userIsSignedUp = true)
		print(userIsSignedUp)
		return userIsSignedUp
	}
	
	static func saveCurrentUserToPersistent() -> Bool {
		if(currentUser != nil) {
			do {
				try managedContext.save()
				dataModelDelegate?.userHasValidated()
				return true
			} catch let error as NSError {
				print("Could not save. \(error), \(error.userInfo)")
				return false
			}
		}
		return false
	}
	
	static func getStudentFromPersistentDM() -> Student? {
		var user: Student? = nil
		
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
		
		do {
			user = try managedContext.fetch(fetchRequest)[0] as? Student
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		return user
	}
	
	static func userWasLoggedIn() -> Bool {
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
		var userWasLoggedIn = false
		
		do {
			let student = try managedContext.fetch(fetchRequest) as! [Student]
			student.count > 0 ? (userWasLoggedIn = true) : (userWasLoggedIn = false)
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		return userWasLoggedIn
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
