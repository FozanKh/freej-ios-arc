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
	
	static func addToPersistentDM(userInfo: JSON) {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		let managedContext = appDelegate.persistentContainer.viewContext
		let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
		let student = NSManagedObject(entity: entity, insertInto: managedContext)
		student.setValue(userInfo["UserID"].stringValue, forKeyPath: "userID")
		student.setValue(userInfo["BNo"].stringValue, forKeyPath: "bno")
		student.setValue(userInfo["FName"].stringValue, forKeyPath: "fName")
		student.setValue(userInfo["LName"].stringValue, forKeyPath: "lName")
		student.setValue(userInfo["KFUPMID"].stringValue, forKeyPath: "kfupmID")
		student.setValue(userInfo["Gender"].stringValue, forKeyPath: "gender")
		student.setValue(userInfo["Stat"].stringValue, forKeyPath: "stat")
		
		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}
}
