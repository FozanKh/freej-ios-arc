//
//  UserProfileVC.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 15/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {
	@IBOutlet weak var kfupmIDTF: UITextField! {
		didSet {
			kfupmIDTF.textColor = .gray
			kfupmIDTF.text = DataModel.currentUser!.kfupmID
		}
	}
	@IBOutlet weak var fNameTF: UITextField! {
		didSet {
			fNameTF.text = DataModel.currentUser!.fName
		}
	}
	
	@IBOutlet weak var lNameTF: UITextField! {
		didSet {
			lNameTF.text = DataModel.currentUser!.lName
		}
	}
	
	@IBOutlet weak var bnoTF: UITextField! {
		didSet {
			bnoTF.text = DataModel.currentUser!.bno
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	@IBAction func submitChanges(_ sender: Any) {
		NetworkManager.updateUserInfo(kfupmID: (DataModel.currentUser?.kfupmID)!, fName: fNameTF.text!, lName: lNameTF.text!, bno: bnoTF.text!) { (success) in
			success ? self.showAlert(title: "Success", message: "User info updated successfully") : self.showAlert(title: "Error", message: "Error while updating user info")
		}
	}
	
	@IBAction func deleteAccount(_ sender: Any) {
		let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you want to delete your account from Freej? This action is cannot be undone", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (UIAlertAction) in
			NetworkManager.deleteStudent(kfupmID: (DataModel.currentUser?.kfupmID!)!) { (success) in
				success ? self.logoutUser() : self.showAlert(title: "Error", message: "Error while deleting your account from the database")
			}
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: .default))
		self.present(alert, animated: true)
	}
	
	func logoutUser() {
		DataModel.clearCurrentUser()
		parent?.navigationController?.popToRootViewController(animated: true)
		self.dismiss(animated: true)
	}
	
	func showAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
		self.present(alert, animated: true)
	}
	
}