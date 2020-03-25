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
	
	static func setCurrentUser(userJSON: JSON, saveToPersistant: Bool) {
		//Set Persistant current user
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		let managedContext = appDelegate.persistentContainer.viewContext
		let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
		let student = NSManagedObject(entity: entity, insertInto: managedContext)
		student.setValue(userJSON["UserID"].stringValue, forKeyPath: "userID")
		student.setValue(userJSON["BNo"].stringValue, forKeyPath: "bno")
		student.setValue(userJSON["FName"].stringValue, forKeyPath: "fName")
		student.setValue(userJSON["LName"].stringValue, forKeyPath: "lName")
		student.setValue(userJSON["KFUPMID"].stringValue, forKeyPath: "kfupmID")
		student.setValue(userJSON["Gender"].stringValue, forKeyPath: "gender")
		student.setValue(userJSON["Stat"].stringValue, forKeyPath: "stat")
		
		
		if(saveToPersistant) {
			do {
				try managedContext.save()
			} catch let error as NSError {
				print("Could not save. \(error), \(error.userInfo)")
			}
		}
		
		//Set Temporary (this session) currentUser
		currentUser = student as? Student
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
