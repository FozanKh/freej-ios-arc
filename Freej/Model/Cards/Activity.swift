//
//  Activity.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 16/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

@objc(Activity)
public class Activity: NSManagedObject {
	static func refreshActivitiesArray(completion: @escaping () -> ()) {
		NetworkManager.request(type: .activity, params: ["BNo" : DataModel.currentUser!.bno!]) { (activitiesJSON, status) in
			getActivitiesDict(fromJSON: activitiesJSON)
			completion()
		}
	}
	
	init(_ acID: Int, _ acTID: Int, _ userID: String, _ title: String, _ descrp: String, _ sDate: String, _ iconURL: String, _ stat: String, _ relationship: ActivityType) {
		let managedContext = DataModel.managedContext
		super.init(entity: NSEntityDescription.entity(forEntityName: "Activity", in: managedContext)!, insertInto: managedContext)
		self.acID = Int32(acID)
		self.acTID = Int32(acTID)
		self.userID = userID
		self.title = title
		self.descrp = descrp
		self.sDate = sDate
		self.iconURL = iconURL
		self.stat = stat
	}
	
	override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
		super.init(entity: entity, insertInto: context)
	}
	
	static func getActivitiesDict(fromJSON: JSON?) {
		
		var jsonArray = fromJSON?.array ?? [JSON]()
		for activityType in DataModel.activityTypesArray! {

			var tempActivityArray = [Activity]()
			for activity in jsonArray {
				if(activity["AcTID"].intValue == activityType.acTID) {
					let acID =	activity["AcID"].intValue
					let acTID =	activity["AcTID"].intValue
					let userID =	activity["UserID"].stringValue
					let title =	activity["Title"].stringValue
					let descrp =	activity["Descrp"].stringValue
					let sDate = 	activity["SDate"].stringValue
					let iconURL = activity["IconURL"].stringValue
					let stat =	activity["Stat"].stringValue
					let relationship = activityType
					
					tempActivityArray.append(Activity(acID, acTID, userID, title, descrp, sDate, iconURL, stat, relationship))
					let indexOfActivity = jsonArray.firstIndex(of: activity)
					if(indexOfActivity != nil) {jsonArray.remove(at: jsonArray.firstIndex(of: activity)!)}
				}
			}
			activityType.relationship = NSSet(array: tempActivityArray)
		}
		DataModel.activityTypesArray = DataModel.activityTypesArray
	}
}
