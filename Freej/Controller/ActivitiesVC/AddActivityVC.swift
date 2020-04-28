//
//  AddActivityVC.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 24/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class AddActivityVC: UIViewController {
	var activityType: ActivityType?

	@IBOutlet weak var activityContent: UITextView!
	@IBOutlet weak var addActivityOutlet: UIButton!
	@IBOutlet weak var titleTF: UITextField!
	
	@IBAction func addActivityBtn(_ sender: Any) {
		let params = ["AcTID" : "\(activityType!.acTID)",
					  "UserID" : DataModel.currentUser!.userID!,
					  "Title" : titleTF.text!,
					  "Descrp" : activityContent.text!,
					  "SDate" : "",
					  "IconURL" : "NA",
					  "Stat" : "Unhandled"]
		NetworkManager.request(type: .addActivity, params: params) { (json, success) in
			print("\(self.activityType?.typeName ?? "no type name") addition status = \(success)")
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		addActivityOutlet.setTitle("Add \(activityType?.typeName! ?? "")", for: .normal)
	}
}
