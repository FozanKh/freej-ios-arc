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
	
	//MARK:- Persistent Data
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
	
	static var whatsAppGroup: String?
	
	//MARK:- Core Data Methods
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
		do {try managedContext.save()}
		catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}
	
	static func clear(entity: Entity) {
		let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue))
		do {try managedContext.execute(DelAllReqVar)}
		catch {print(error)}
	}
	
	//MARK:- JSON Parsing Methods
	//This method will load the session data according to the internet connection the user has
	static func loadSessionData(completion: @escaping () -> ()) {
		let params = ["UserID" : currentUser?.userID ?? "NA",
					  "BNo" : currentUser?.bno ?? "NA"]
		NetworkManager.request(type: .sessionData, params: params) { (json, success) in
			if success {
				setActivitiesArrays(from: json)
				setAnnoucementsArray(from: json)
				whatsAppGroup = json?["GroupURL"][0].stringValue
			} else {
				activityTypesArray = fetch(entity: .activityType) as? [ActivityType]
				announcementsArray = fetch(entity: .announcement) as? [Announcement]
			}
			completion()
		}
	}
	
	//This method will clear the previous array of activity types, and create a new one from the json
	static func setActivitiesArrays(from json: JSON?) {
		clear(entity: .activityType)
		
		var tempActivityTypesArray = [ActivityType]()
		
		var jsonAcivitiesArray = json?["Activity"].array ?? [JSON]()
		let jsonActivityTypesArray = json?["ActivityType"].array ?? [JSON]()
		
		for activityType in jsonActivityTypesArray {
			let at = ActivityType(json: activityType)
			
			for activity in jsonAcivitiesArray {
				if activity["AcTID"].int32Value == at.acTID {
					at.addToBuildingActivities(Activity(json: activity))
					
					if activity["UserID"].stringValue == currentUser?.userID {
						at.addToStudentActivities(Activity(json: activity))
					}
					jsonAcivitiesArray.remove(at: jsonAcivitiesArray.firstIndex(of: activity)!)
				}
			}
			tempActivityTypesArray.append(at)
		}
		activityTypesArray = tempActivityTypesArray
	}
	
	//This method will clear the previous array of announcements, and create a new one from the json
	static func setAnnoucementsArray(from json: JSON?) {
		clear(entity: .announcement)
		var anArray = [Announcement]()
		for an in json?["Announcement"].array ?? [JSON]() {
			anArray.append(Announcement(json: an))
		}
		announcementsArray = anArray
	}
}
