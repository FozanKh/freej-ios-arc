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

enum Entity: String {
	case student = "Student", activityType = "ActivityType"
}

class DataModel {
	static var activityTypesArray: [ActivityType]? {
		didSet {
			saveSession()
		}
	}
	
	static var currentUser: Student? {
		didSet {
			
		}
	}
	
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
	
	static func fetch(entity: Entity) -> [NSManagedObject]? {
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity.rawValue)
		var fetchedResult: [NSManagedObject]?
		
		do {
			fetchedResult = try managedContext.fetch(fetchRequest)
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		
		//should call validate entity here
		return fetchedResult
	}
	
	static func saveSession() {
		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}
	
	static func loadSessionData(completion: @escaping () -> ()) {
		ActivityType.refreshActivityTypesArray { activityTypesDidDownload in
			//If the activity types were not downloaded successfully.
			//activities shall not be downloaded as it may contain activity types which are not in the activityTypesArray saved in CoreData which will case a crash to the application.
			if(activityTypesDidDownload) {
				Activity.refreshActivitiesArray {
					Announcement.refreshAnnouncementsArray {
						completion()
						saveCurrentUserToPersistent()
					}
				}
			}
			else {
				Announcement.refreshAnnouncementsArray {
					completion()
					saveCurrentUserToPersistent()
				}
			}
		}
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
	
	static func clear(entity: Entity) {
		let managedContext = appDelegate.persistentContainer.viewContext
		let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue))
		do {
			try managedContext.execute(DelAllReqVar)
		}
		catch {
			print(error)
		}
		
		switch entity {
		case .activityType:
			activityTypesArray = nil
		case .student:
			currentUser = nil
		}
	}
}
