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
	
	static var activitiesArray: [Activity]?
	
	static func refreshActivitiesArray() {
		NetworkManager.getActivities(bno: DataModel.currentUser!.bno!) { (activitiesJSON) in
			if(activitiesJSON == nil) {activitiesArray = [Activity]()}
			else {
				activitiesArray = activitiesArray(fromJSON: activitiesJSON!)
			}
		}
	}
	
	static func getCount(id: Int) -> Int {
		var count = 0
		for activity in activitiesArray! {
			if(activity.acTID == id) {count += 1}
		}
		return count
	}
	
	static func getActivityArray(filterAcTID: Int) -> [Activity] {
		var speceficArray = [Activity]()
		print(filterAcTID)
		for specefic in activitiesArray! {
			if(specefic.acTID == filterAcTID) {
				speceficArray.append(specefic)
			}
		}
		return speceficArray
	}
	
	static func activitiesArray(fromJSON: JSON) -> [Activity] {
		var acArray = [Activity]()
		for ac in fromJSON.array! {
			let dbAcID =	ac["AcID"].intValue
			let dbAcTID =	ac["AcTID"].intValue
			let dbUserID =	ac["UserID"].stringValue
			let dbTitle =	ac["Title"].stringValue
			let dbDescrp =	ac["Descrp"].stringValue
			let dbSDate = 	ac["SDate"].stringValue
			let dbIconURL =	ac["IconURL"].stringValue
			let dbStat =	ac["Stat"].stringValue
			
			acArray.append(Activity(acID: dbAcID, acTID: dbAcTID, creatorID: dbUserID, title: dbTitle, descrp: dbDescrp, sDate: dbSDate, iconURL: dbIconURL, stat: dbStat))
		}
		return acArray
	}
}
