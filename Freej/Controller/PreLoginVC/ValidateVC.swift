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
	var correctOtp: String! {
		didSet {
			validationCodeTF.text = correctOtp
		}
	}
	
	var otpGenerationTime: Date!
	
	override func loadView() {
		super.loadView()
		generateOTP()
	}
	
	@IBAction func loginButton(_ sender: Any) {
		progressManager.show(in: view, animated: true)
		let userEnteredOTP = validationCodeTF.text ?? "0"
		
		if(userEnteredOTP == correctOtp) {
			DataModel.loadSessionData {
				if(DataModel.currentUser?.isSignedUp() ?? false) {
					DataModel.currentUser?.isLoggedIn = true
					DataModel.currentUser = DataModel.currentUser
					DataModel.saveSession()
					self.progressManager.dismiss()
					self.dismiss(animated: true)
				}
				else {
					DataModel.currentUser?.signUp(completion: { (dbStuJSON) in
						if(dbStuJSON != nil) {
							let student = Student.createStudent(fromJSON: dbStuJSON![0], isLoggedIn: true)
							DataModel.currentUser = student
							DataModel.saveSession()
							self.progressManager.dismiss()
							self.dismiss(animated: true)
						}
						else {
							self.progressManager.dismiss()
							self.showAlert("Error while signing up a new user.")
						}
					})
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
		let params = ["to" : "abdulelahhajjar@gmail.com", "otp" : correctOtp!]
		
		NetworkManager.boolRequest(type: .sendOTP, params: params) { (hasSent) in
			if(!hasSent) {
				self.showAlert("The application encountered an error while sending the OTP.")
			}
			print(self.correctOtp!)
		}
	}
	
	func showAlert(_ message: String) {
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (UIAlertAction) in
			self.generateOTP()
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (UIAlertAction) in
			self.dismiss(animated: true)
			DataModel.clear(entity: .student)
		}))
		self.present(alert, animated: true)
	}
}
