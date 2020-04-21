//
//  Activity.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 16/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Activity: NSObject, NSSecureCoding {
	public static var supportsSecureCoding: Bool = true
	
	public func encode(with coder: NSCoder) {
		coder.encode(acID, forKey: "acID")
		coder.encode(acTID, forKey: "acTID")
		coder.encode(userID, forKey: "userID")
		coder.encode(title, forKey: "title")
		coder.encode(descrp, forKey: "descrp")
		coder.encode(sDate, forKey: "sDate")
		coder.encode(iconURL, forKey: "iconURL")
		coder.encode(stat, forKey: "stat")
	}
	
	public required convenience init?(coder: NSCoder) {
		let dAcID: Int = coder.decodeObject(of: NSNumber.self, forKey: "acID") as? Int ?? -1
		let dAcTID: Int = coder.decodeObject(of: NSNumber.self, forKey: "acTID") as? Int ?? -1
		let dUserID: String = coder.decodeObject(of: NSString.self, forKey: "userID") as String? ?? "NA"
		let dTitle: String = coder.decodeObject(of: NSString.self, forKey: "title") as String? ?? "NA"
		let dDescrp: String = coder.decodeObject(of: NSString.self, forKey: "descrp") as String? ?? "NA"
		let dSDate: String = coder.decodeObject(of: NSString.self, forKey: "sDate") as String? ?? "NA"
		let dIconURL: String = coder.decodeObject(of: NSString.self, forKey: "iconURL") as String? ?? "NA"
		let dStat: String = coder.decodeObject(of: NSString.self, forKey: "stat") as String? ?? "NA"
		
		self.init(acID: dAcID, acTID: dAcTID, userID: dUserID, title: dTitle, descrp: dDescrp, sDate: dSDate, iconURL: dIconURL, stat: dStat)
	}
	
	init(acID: Int, acTID: Int, userID: String, title: String, descrp: String, sDate: String, iconURL: String, stat: String) {
		self.acID = acID
		self.acTID = acTID
		self.userID = userID
		self.title = title
		self.descrp = descrp
		self.sDate = sDate
		self.iconURL = iconURL
		self.stat = stat
	}
	
	var acID:		Int?
	var acTID:		Int?
	var userID:		String?
	var title:		String?
	var descrp:		String?
	var sDate:		String?
	var iconURL:	String?
	var stat:		String?
	
	static var activitiesDict: [ActivityType : [Activity]]?
	
	static func refreshActivitiesArray(completion: @escaping () -> ()) {
		NetworkManager.jsonRequest(type: .activity, params: ["BNo" : DataModel.currentUser!.bno!]) { (activitiesJSON) in
			if (activitiesJSON == nil) {
				activitiesDict = [ActivityType : [Activity]]()
				completion()
			}
			else {
				activitiesDict = getActivitiesDict(fromJSON: activitiesJSON!)
				
				completion()
			}
		}
	}
	
	static func getActivitiesDict(fromJSON: JSON) -> [ActivityType : [Activity]] {
		var dict = [ActivityType : [Activity]]()
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
					
					tempActivityArray.append(Activity(acID: dbAcID, acTID: dbAcTID, userID: dbUserID, title: dbTitle, descrp: dbDescrp, sDate: dbSDate, iconURL: dbIconURL, stat: dbStat))
					let indexOfActivity = jsonArray.firstIndex(of: activity)
					if(indexOfActivity != nil) {jsonArray.remove(at: jsonArray.firstIndex(of: activity)!)}
				}
			}
			dict[activityType] = tempActivityArray
			
		}
		
		return dict
	}
}
