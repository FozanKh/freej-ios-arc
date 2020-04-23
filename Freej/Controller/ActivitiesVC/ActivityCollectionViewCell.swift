//
//  ActivityCollectionViewCell.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 16/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class ActivityCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var descrp: UILabel!
	@IBOutlet weak var sDate: UILabel!
	@IBOutlet weak var iconURL: UILabel!
	
	@IBOutlet weak var deleteOutlet: UIButton!
	
	@IBAction func deleteAction(_ sender: Any) {
		NetworkManager.request(type: .deleteActivity, params: ["AcID" : "\(activity.acID)"]) { (json, status) in
			print("Deletion status = \(status)")
		}
	}
	
	var activity: Activity! {
		didSet {
			title.text = activity.title
			descrp.text = activity.descrp
			sDate.text = activity.sDate
			iconURL.text = activity.iconURL
			let cannotDelete = activity.userID != DataModel.currentUser?.userID
			deleteOutlet.isHidden = (cannotDelete && !(DataModel.currentUser?.isAmeen ?? false))
		}
	}
	
	
}
