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
	static var activityTypesArray: [ActivityType]?
	
	static func refreshActivityTypesArray(completion: @escaping (Bool) -> ()) {
		NetworkManager.jsonRequest(type: .activityType, params: nil) { (activityTypesJSON) in
			if (activityTypesJSON == nil) {
				activityTypesArray = DataModel.getActivityTypesFromPersistent()
				completion(false)
			}
			else {
				activityTypesArray = activityTypesArray(fromJSON: activityTypesJSON!)
				completion(true)
			}
		}
	}
	
	static func activityTypesArray(fromJSON: JSON) -> [ActivityType]? {
		var atArray = [ActivityType]()
		DataModel.cleaActivityTypes()
		
		for activityType in fromJSON.array! {
			let at = DataModel.instantiateEmptyActivityType()
			
			at.acTID = Int32(exactly: activityType["AcTID"].intValue) ?? 0
			at.typeName = activityType["TypeName"].stringValue
			at.color1 = activityType["Color1"].stringValue
			at.color2 = activityType["Color2"].stringValue
			
			atArray.append(at)
		}
		activityTypesArray = atArray
		return atArray
	}
}
