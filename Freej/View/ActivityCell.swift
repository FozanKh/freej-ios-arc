//
//  ActivityCell.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 28/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
	@IBOutlet weak var cellBackground: UIView!
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
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	override func layoutSubviews() {
		super.layoutSubviews()
		setupCellBackground()
	}

	func setupCellBackground() {
		cellBackground.layer.masksToBounds = true
		cellBackground.layer.shadowOpacity = 0.75
		cellBackground.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
		cellBackground.layer.shadowRadius = 3.5
		cellBackground.layer.masksToBounds = false
	}
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
