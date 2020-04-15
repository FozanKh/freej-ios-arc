//
//  ValidateViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 20/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class ValidateVC: UIViewController {
	@IBOutlet weak var validationCodeTF: UITextField!
	let progressManager = JGProgressHUD()
	var correctOtp: String!
	var otpGenerationTime: Date!
	
	override func loadView() {
		super.loadView()
		generateOTP()
	}
	
	@IBAction func loginButton(_ sender: Any) {
		let userEnteredOTP = validationCodeTF.text ?? "0"
		if(userEnteredOTP == correctOtp) {
			if(DataModel.userIsSignedUp()) {
				//Save to persistent for future sessions (Only logged-in users are saved to persistent)
				let _ = DataModel.saveCurrentUserToPersistent()
			}
			else {
				let user = DataModel.currentUser!
				NetworkManager.signUpUser(user.kfupmID!, user.fName!, user.lName!, user.bno!) { (dbStu) in
					dbStu == nil ? self.showAlert("Error while signing up a new user.") : DataModel.setCurrentStudent(student: dbStu!, saveToPersistent: true)
				}
			}
		}
		else {
			showAlert("The entered OTP did not match our records.")
		}
	}
	
	//This method will randomly generate OTP, and send it to user.
	func generateOTP() {
		correctOtp = "\(Int.random(in: 1000...9999))"
		otpGenerationTime = Date()
		
		NetworkManager.sendOTP(toEmail: (DataModel.currentUser?.kfupmID!)! + "@kfupm.edu.sa", otp: correctOtp) {(hasSent) in
			if(!hasSent) {
				self.showAlert("The application encountered an error while sending the OTP.")
			}
		}
	}
	
	func showAlert(_ message: String) {
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (UIAlertAction) in
			self.generateOTP()
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (UIAlertAction) in
			self.dismiss(animated: true)
			DataModel.clearCurrentUser()
		}))
		self.present(alert, animated: true)
	}
}
