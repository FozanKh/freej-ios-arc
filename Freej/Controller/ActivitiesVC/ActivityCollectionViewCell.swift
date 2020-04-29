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
	@IBOutlet weak var cellBackground: UIView!
	
	@IBOutlet weak var deleteOutlet: UIButton!
	
	@IBAction func deleteAction(_ sender: Any) {
		NetworkManager.request(type: .deleteActivity, params: ["AcID" : "\(activity.acID)"]) { (json, status) in
			print("Deletion status = \(status)")
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layoutIfNeeded()
	}
	
	override func layoutIfNeeded() {
		super.layoutIfNeeded()
		setUpInitialSettingsForViews()
		setupCellBackgroundGradient()
		setupCellBackgroundShadows()
	}
	
	func setUpInitialSettingsForViews() {
		cellBackground.layer.cornerRadius = 16
	}
	
	func setupCellBackgroundShadows() {
		cellBackground.layer.masksToBounds = true
		cellBackground.layer.shadowOpacity = 0.20
		cellBackground.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
		cellBackground.layer.shadowRadius = 4
		cellBackground.layer.masksToBounds = false
	}
	
	func setupCellBackgroundGradient() {
		let gradientView = getGradientViewFromColors()
		cellBackground.insertSubview(gradientView, at: 0)
	}
	
	func getGradientViewFromColors() -> UIView {
		let gradient = CAGradientLayer()
		gradient.frame = cellBackground.bounds
		gradient.colors = [DataModel.cgColor(withHex: activity.inverseBuilding?.colorDark ?? "FFFFFF"),
						   DataModel.cgColor(withHex: activity.inverseBuilding?.colorLight ?? "FFFFFF")]
		gradient.startPoint = CGPoint(x: 1, y: 1)
		gradient.endPoint = CGPoint(x: 0, y: 0)
		
		let gradientView = UIView()
		gradientView.frame = cellBackground.bounds
		gradientView.layer.insertSublayer(gradient, at: 0)
		gradientView.layer.cornerRadius = 16
		gradientView.clipsToBounds = true
		
		return gradientView
	}
	
	var activity: Activity! {
		didSet {
			title.text = activity.title
			descrp.text = activity.descrp
			sDate.text = activity.sDate
			let cannotDelete = activity.userID != DataModel.currentUser?.userID
			deleteOutlet.isHidden = (cannotDelete && !(DataModel.currentUser?.isAmeen ?? false))
		}
	}
	
	
}
