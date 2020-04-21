//
//  ActivityType.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 16/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ActivityType: NSObject, NSSecureCoding {
	public static var supportsSecureCoding: Bool = true
	
	public func encode(with coder: NSCoder) {
		coder.encode(acTID, forKey: "acTID")
		coder.encode(typeName, forKey: "typeName")
		coder.encode(color1, forKey: "color1")
		coder.encode(color2, forKey: "color2")
	}
	
	public required convenience init?(coder: NSCoder) {
		let dAcTID = coder.decodeObject(of: NSNumber.self, forKey: "acTID") as? Int
		let dTypeName = coder.decodeObject(of: NSString.self, forKey: "typeName") as String?
		let dColor1 = coder.decodeObject(of: NSString.self, forKey: "color1") as String?
		let dColor2 = coder.decodeObject(of: NSString.self, forKey: "color2") as String?
		
		self.init(acTID: dAcTID ?? -1, typeName: dTypeName ?? "NA", color1: dColor1 ?? "000000", color2: dColor2 ?? "000000")
	}
	
	init(acTID: Int, typeName: String, color1: String, color2: String) {
		self.acTID = acTID
		self.typeName = typeName
		self.color1 = color1
		self.color2 = color2
	}
	
	let acTID:		Int
	let typeName:	String
	let color1:		String
	let color2:		String
	
	static var activityTypesArray: [ActivityType]?
	
	static func refreshActivityTypesArray(completion: @escaping (Bool) -> ()) {
		NetworkManager.jsonRequest(type: .activityType, params: nil) { (activityTypesJSON) in
			if (activityTypesJSON == nil) {
				activityTypesArray = [ActivityType]()
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
		for at in fromJSON.array! {
			let dbAcTID =		at["AcTID"].intValue
			let dbTypeName =	at["TypeName"].stringValue
			let dbColor1Hex =	at["Color1"].stringValue
			let dbColor2Hex =	at["Color2"].stringValue
			atArray.append(ActivityType(acTID: dbAcTID, typeName: dbTypeName, color1: dbColor1Hex, color2: dbColor2Hex))
		}
		activityTypesArray = atArray
		return atArray
	}
}
