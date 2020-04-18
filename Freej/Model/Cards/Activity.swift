//
//  Activity.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 16/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Activity {
	let acID:		Int
	let acTID:		Int
	let creatorID:	String
	let title:		String
	let descrp:		String
	let sDate:		String
	let iconURL:	String
	let stat:		String
	
	static var activitiesDict: [Int : [Activity]]?
	
	static func refreshActivitiesArray(completion: @escaping () -> ()) {
		NetworkManager.jsonRequest(type: .activity, params: ["BNo" : DataModel.currentUser!.bno!]) { (activitiesJSON) in
			if (activitiesJSON == nil) {
				activitiesDict = [Int : [Activity]]()
				completion()
			}
			else {
				activitiesDict = getActivitiesDict(fromJSON: activitiesJSON!)
				
				completion()
			}
		}
	}
	
	static func getActivitiesDict(fromJSON: JSON) -> [Int : [Activity]] {
		var dict = [Int : [Activity]]()
		var jsonArray = fromJSON.array!
		
		for activityType in ActivityType.activityTypesArray! {
			var tempActivityArray = [Activity]()
			
			for activity in jsonArray {
				if(activity["AcTID"].intValue == activityType.acTID) {
					let dbAcID =	activity["AcID"].intValue
					let dbAcTID =	activity["AcTID"].intValue
					let dbUserID =	activity["UserID"].stringValue
					let dbTitle =	activity["Title"].stringValue
					let dbDescrp =	activity["Descrp"].stringValue
					let dbSDate = 	activity["SDate"].stringValue
					let dbIconURL =	activity["IconURL"].stringValue
					let dbStat =	activity["Stat"].stringValue
					
					tempActivityArray.append(Activity(acID: dbAcID, acTID: dbAcTID, creatorID: dbUserID, title: dbTitle, descrp: dbDescrp, sDate: dbSDate, iconURL: dbIconURL, stat: dbStat))
					let indexOfActivity = jsonArray.firstIndex(of: activity)
					if(indexOfActivity != nil) {jsonArray.remove(at: jsonArray.firstIndex(of: activity)!)}
				}
			}
			dict[activityType.acTID] = tempActivityArray
			
		}
		
		return dict
	}
}
