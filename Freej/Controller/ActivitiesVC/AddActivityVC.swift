//
//  AddActivityVC.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 24/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class AddActivityVC: UIViewController {
	
	@IBOutlet weak var activityContent: UITextView!
	@IBOutlet weak var addActivityOutlet: UIButton!
	@IBAction func addActivityBtn(_ sender: Any) {
		
	}
	
	var activityType: ActivityType?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print(activityType)
	}
}
