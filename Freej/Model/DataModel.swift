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
	case student = "Student", activityType = "ActivityType", announcement = "Announcement"
}

class DataModel {
	static let appDelegate = UIApplication.shared.delegate as! AppDelegate
	static let managedContext = appDelegate.persistentContainer.viewContext
	static var dataModelDelegate: DataModelProtocol?
	
	static var activityTypesArray: [ActivityType]? {
		didSet {saveSession()}
	}
	
	static var announcementsArray: [Announcement]? {
		didSet {saveSession()}
	}
	
	static var currentUser: Student? {
		didSet {
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
		let params = ["UserID" : currentUser?.userID ?? "NA",
					  "BNo" : currentUser?.bno ?? "NA"]
		NetworkManager.request(type: .sessionData, params: params) { (json, success) in
			if success {
				setActivitiesArrays(from: json)
				setAnnoucementsArray(from: json)
			} else {
				activityTypesArray = fetch(entity: .activityType) as? [ActivityType]
				announcementsArray = fetch(entity: .announcement) as? [Announcement]
			}
			completion()
		}
	}
	
	static func clear(entity: Entity) {
		let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue))
		do {try managedContext.execute(DelAllReqVar)}
		catch {print(error)}
	}
	
	static func setAnnoucementsArray(from json: JSON?) {
		clear(entity: .announcement)
		var anArray = [Announcement]()
		for an in json?["Announcement"].array ?? [JSON]() {
			anArray.append(Announcement(json: an))
		}
		announcementsArray = anArray
	}
	
	static func setActivitiesArrays(from json: JSON?) {
		clear(entity: .activityType)
		
		var tempActivityTypesArray = [ActivityType]()
		var activitiesArray = json?["Activity"].array ?? [JSON]()
		
		for activityType in json?["ActivityType"].array ?? [JSON]() {
			let at = ActivityType(json: activityType)
			
			for activity in activitiesArray {
				if activity["AcTID"].int32Value == at.acTID {
					at.addToBuildingActivities(Activity(json: activity))
					
					if activity["UserID"].stringValue == currentUser?.userID {
						at.addToStudentActivities(Activity(json: activity))
					}
					activitiesArray.remove(at: activitiesArray.firstIndex(of: activity)!)
				}
			}
			tempActivityTypesArray.append(at)
		}
		activityTypesArray = tempActivityTypesArray
	}
}
