//
//  ActivityType.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 16/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

@objc(ActivityType)
public class ActivityType: NSManagedObject {
	static func refreshActivityTypesArray(completion: @escaping (Bool) -> ()) {
		NetworkManager.request(type: .activityType, params: nil) { (activityTypesJSON, status) in
			if (activityTypesJSON == nil) {
				DataModel.activityTypesArray = (DataModel.fetch(entity: .activityType) ?? [ActivityType]()) as? [ActivityType]
				completion(false)
				//check activitirs
			}
			else {
				DataModel.activityTypesArray = getActivityTypesArray(fromJSON: activityTypesJSON!)
				completion(true)
			}
		}
	}
	
	init(acTID: Int, typeName: String, color1: String, color2: String) {
		let managedContext = DataModel.managedContext
		super.init(entity: NSEntityDescription.entity(forEntityName: "ActivityType", in: managedContext)!, insertInto: managedContext)
		self.acTID = Int32(acTID)
		self.typeName = typeName
		self.color1 = color1
		self.color2 = color2
	}
	
	override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
		super.init(entity: entity, insertInto: context)
	}
	
	static func getActivityTypesArray(fromJSON: JSON) -> [ActivityType]? {
		var atArray = [ActivityType]()
		DataModel.clear(entity: .activityType)
		
		for activityType in fromJSON.array! {
			let acTID = activityType["AcTID"].intValue
			let typeName = activityType["TypeName"].stringValue
			let color1 = activityType["Color1"].stringValue
			let color2 = activityType["Color2"].stringValue
			
			atArray.append(ActivityType(acTID: acTID, typeName: typeName, color1: color1, color2: color2))
		}
		return atArray
	}
}
