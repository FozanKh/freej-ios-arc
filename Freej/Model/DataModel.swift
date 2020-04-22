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
	static let appDelegate = UIApplication.shared.delegate as! AppDelegate
	static let managedContext = appDelegate.persistentContainer.viewContext
	static var dataModelDelegate: DataModelProtocol?
	
	static var activityTypesArray: [ActivityType]? {
		didSet {
			saveSession()
		}
	}
	
	static var currentUser: Student? {
		didSet {
			print("here543453455346")
			saveSession()
			if currentUser?.isLoggedIn ?? false && currentUser?.isSignedUp() ?? false {dataModelDelegate?.userHasValidated()}
		}
	}
		
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
			if(activityTypesDidDownload) {
				Activity.refreshActivitiesArray {
					Announcement.refreshAnnouncementsArray {completion()}
				}
			}
			else {
				Announcement.refreshAnnouncementsArray {completion()}
			}
		}
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
