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
	
	init(acTID: Int, typeName: String, colorLight: String, colorDark: String) {
		let managedContext = DataModel.managedContext
		super.init(entity: NSEntityDescription.entity(forEntityName: "ActivityType", in: managedContext)!, insertInto: managedContext)
		self.acTID = Int32(acTID)
		self.typeName = typeName
		self.colorLight = colorLight
		self.colorDark = colorDark
	}
	
	init(json: JSON) {
		let managedContext = DataModel.managedContext
		super.init(entity: NSEntityDescription.entity(forEntityName: "ActivityType", in: managedContext)!, insertInto: managedContext)
		acTID = Int32(json["AcTID"].intValue)
		typeName = json["TypeName"].stringValue
		colorLight = json["ColorLight"].stringValue
		colorDark = json["ColorDark"].stringValue
	}
	
	override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
		super.init(entity: entity, insertInto: context)
	}
}
