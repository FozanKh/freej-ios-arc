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
	
	init(json: JSON) {
		let managedContext = DataModel.managedContext
		super.init(entity: NSEntityDescription.entity(forEntityName: "Activity", in: managedContext)!, insertInto: managedContext)
		acID =		Int32(json["AcID"].intValue)
		acTID =		Int32(json["AcTID"].intValue)
		userID =	json["UserID"].stringValue
		title =		json["Title"].stringValue
		descrp =	json["Descrp"].stringValue
		sDate = 	json["SDate"].stringValue
		iconURL = 	json["IconURL"].stringValue
		stat =		json["Stat"].stringValue
	}

}
