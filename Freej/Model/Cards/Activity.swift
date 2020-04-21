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
		NetworkManager.jsonRequest(type: .activity, params: ["BNo" : DataModel.currentUser!.bno!]) { (activitiesJSON) in
			getActivitiesDict(fromJSON: activitiesJSON)
			completion()
		}
	}
	
	static func getActivitiesDict(fromJSON: JSON?) {
		
		var jsonArray = fromJSON?.array ?? [JSON]()
		for activityType in ActivityType.activityTypesArray! {

			var tempActivityArray = [Activity]()
			for activity in jsonArray {
				if(activity["AcTID"].intValue == activityType.acTID) {
					let ac = DataModel.instantiateEmptyActivity()
					ac.acID =	Int32(activity["AcID"].intValue)
					ac.acTID =	Int32(activity["AcTID"].intValue)
					ac.userID =	activity["UserID"].stringValue
					ac.title =	activity["Title"].stringValue
					ac.descrp =	activity["Descrp"].stringValue
					ac.sDate = 	activity["SDate"].stringValue
					ac.iconURL = activity["IconURL"].stringValue
					ac.stat =	activity["Stat"].stringValue
					ac.relationship = activityType
					tempActivityArray.append(ac)
					let indexOfActivity = jsonArray.firstIndex(of: activity)
					if(indexOfActivity != nil) {jsonArray.remove(at: jsonArray.firstIndex(of: activity)!)}
				}
			}
			activityType.relationship = NSSet(array: tempActivityArray)
		}
	}
}
