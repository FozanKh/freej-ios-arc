//
//  Announcement.swift
//  Freej
//
//  Created by khaled khamis on 29/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Announcement {
    var icon : UIImage
    var type : String
    var content : String
    var atID : String
	var userid: String
    
	static var ancmtsArray: [Announcement]?
	
	static func refreshAnnouncementsArray(completion: @escaping () -> ()) {
		NetworkManager.jsonRequest(type: .announcement, params: nil) { (ancmtsJSON) in
			if (ancmtsJSON == nil) {
				ancmtsArray = [Announcement]()
				completion()
			}
			else {
				ancmtsArray = announcementsArray(fromJSON: ancmtsJSON!)
				completion()
			}
		}
	}
	
	func addToDatabase(completion: @escaping (Bool) -> ()) {
		let params =   ["AnTID" : atID,
						"UserID" : userid,
						"Title" : atID,
						"Descrp" : content,
						"SDate" : "2020-20-02",
						"Stat" : "Activated"]
		
		NetworkManager.boolRequest(type: .addAnnouncement, params: params) { (success) in completion(success)}
	}
	
	static func announcementsArray(fromJSON: JSON) -> [Announcement] {
		var anArray = [Announcement]()
		for an in fromJSON.array! {
			let dbType = "General"
			let dbContent = an["Descrp"].stringValue
			let dbUserID = an["UserID"].stringValue
			anArray.append(Announcement(type: dbType, content: dbContent, userid: dbUserID))
		}
		return anArray
	}
	
	init(type : String, content : String, userid: String) {
        self.type = type
        switch type {
        case "General":
            self.icon = UIImage(systemName: "mic.fill")!
            atID = "1"
        case "Specific":
            self.icon = UIImage(systemName: "bubble.left.fill")!
            atID = "2"
        default:
            self.icon = UIImage(systemName: "person.fill")!
            atID = "3"
        }
        self.content = content
		self.userid = userid
    }
}
