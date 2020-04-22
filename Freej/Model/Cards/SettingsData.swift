//
//  SettingsData.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 14/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import UIKit

struct SettingsData {
	static let userSettings = [	SettingsCellData(cellTitle: "Profile", cellIcon: "person", cellSegueID: "toEditProfile"),
								SettingsCellData(cellTitle: "Recent Activity", cellIcon: "arrow.clockwise.circle", cellSegueID: "toAllActivities"),
								SettingsCellData(cellTitle: "Personalization", cellIcon: "paintbrush", cellSegueID: "toPersonalization"),
								SettingsCellData(cellTitle: "Building WhatsApp Group", cellIcon: "phone.circle", cellSegueID: "toWhatsappGroup")]
								
	static let appSettings = [	SettingsCellData(cellTitle: "Report Problem", cellIcon: "exclamationmark.triangle", cellSegueID: "toReportProblem"),
								SettingsCellData(cellTitle: "Contact Us", cellIcon: "paperplane", cellSegueID: "toContactUs"),
								SettingsCellData(cellTitle: "Privacy Policy", cellIcon: "doc.plaintext", cellSegueID: "toPrivacypolicy"),
								SettingsCellData(cellTitle: "Credits", cellIcon: "doc.plaintext", cellSegueID: "toCredits")]
	
	static let logoutSection = [SettingsCellData(cellTitle: "Log Out", cellIcon: "delete.right", cellSegueID: "toLogOut")]
	static let sections = [userSettings, appSettings, logoutSection]
}


struct SettingsCellData {
	let cellTitle:	String
	let cellIcon:	String
	let cellSegueID:String
	
	func getImage() -> UIImage {
		return UIImage(systemName: cellIcon) ?? UIImage(named: cellIcon) ?? UIImage.checkmark
	}
}
