//
//  Announcement.swift
//  Freej
//
//  Created by khaled khamis on 29/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

@objc(Announcement)
public class Announcement: NSManagedObject {
	
	init(anTID: Int, userID: String, title: String, descrp: String, sDate: String) {
		let managedContext = DataModel.managedContext
		super.init(entity: NSEntityDescription.entity(forEntityName: "Announcement", in: managedContext)!, insertInto: managedContext)
		self.anTID = Int32(anTID)
		self.userID = userID
		self.title = title
		self.descrp = descrp
		self.sDate = sDate
	}
	
	init(json: JSON) {
		let managedContext = DataModel.managedContext
		super.init(entity: NSEntityDescription.entity(forEntityName: "Announcement", in: managedContext)!, insertInto: managedContext)
		anID =		Int32(json["AnID"].intValue)
		anTID =		Int32(json["AnTID"].intValue)
		userID =	json["UserID"].stringValue
		title =		json["Title"].stringValue
		descrp =	json["Descrp"].stringValue
		sDate = 	json["SDate"].stringValue
		stat = 		json["Stat"].stringValue
	}
	
	override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
		super.init(entity: entity, insertInto: context)
	}
	
	func addToDatabase(completion: @escaping (Bool) -> ()) {
		let params =   ["AnTID" : "\(anTID)",
						"UserID" : userID!,
						"Title" : title!,
						"Descrp" : descrp!,
						"SDate" : "",
						"Stat" : "Active"]
		
		NetworkManager.request(type: .addAnnouncement, params: params) { (json, success) in
			completion(success)
		}
	}
}
