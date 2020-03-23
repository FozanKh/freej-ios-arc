//
//  User.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 23/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
	static var userID: String?
	static var bno: String?
	static var fName: String?
	static var lName: String?
	static var kfupmID: String?
	static var gender: String?
	static var stat: String?
	
	static func assignAttributesAndSaveUser(json: JSON) {
		userID = json["UserID"].stringValue
		bno = json["BNo"].stringValue
		fName = json["FName"].stringValue
		lName = json["LName"].stringValue
		kfupmID = json["KFUPMID"].stringValue
		gender = json["Gender"].stringValue
		stat = json["Stat"].stringValue
		
		//save user
	}
	
	static func clearAttributesAndDeleteUser() {
		userID = nil
		bno = nil
		fName = nil
		lName = nil
		kfupmID = nil
		gender = nil
		stat = nil
		
		//delete user
	}
}
