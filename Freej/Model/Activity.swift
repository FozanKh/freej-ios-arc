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
	let SDate:		String
	let iconURL:	String
	
	static var activitiesArray: [Activity]?
	
	static func refreshActivitiesArray() {
		NetworkManager.getActivities { (activitiesJSON) in
			if(activitiesJSON == nil) {activitiesArray = [Activity]()}
			else {
				activitiesArray = activitiesArray(fromJSON: activitiesJSON!)
			}
		}
	}
	
	static func activitiesArray(fromJSON: JSON) -> [Activity] {
		var acArray = [Activity]()
		for _ in fromJSON.array! {
			let dbAcID =	fromJSON["AcID"].intValue
			let dbAcTID =	fromJSON["AcTID"].intValue
			let dbUserID =	fromJSON["UserID"].stringValue
			let dbTitle =	fromJSON["Title"].stringValue
			let dbDescrp =	fromJSON["Descrp"].stringValue
			let dbSDate = 	fromJSON["SDate"].stringValue
			let dbIconURL =	fromJSON["IconURL"].stringValue
			acArray.append(Activity(acID: dbAcID, acTID: dbAcTID, creatorID: dbUserID, title: dbTitle, descrp: dbDescrp, SDate: dbSDate, iconURL: dbIconURL))
		}
		return acArray
	}
}
