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

protocol NewUserLoginProtocol {
	func newUserHasValidated(completion: @escaping (Bool) -> ())
}

class ValidateViewController: UIViewController {
	@IBOutlet weak var validationCodeTF: UITextField!
	
	let progressManager = JGProgressHUD()
	
	var loginStatus: Bool!
	var correctOtp: String!
	var otpGenerationTime: Date!
	
	var newUserLoginDelegate: NewUserLoginProtocol?
	
	override func loadView() {
		super.loadView()
		generateOTP()
		
	}
	
	@IBAction func loginButton(_ sender: Any) {
		let userEnteredOTP = validationCodeTF.text ?? "0"
		if(userEnteredOTP == correctOtp) {
			let parentVC = parent as! EnterFreejNavController
			if(DataModel.userIsSignedUp()) {
				let _ = DataModel.saveCurrentUserToPersistent()
				parentVC.finishedLoginProcess(loginStatus: true)
			}
			else {
				progressManager.show(in: self.view)
				newUserLoginDelegate?.newUserHasValidated(completion: { (success) in
					self.progressManager.dismiss(animated: true)
					parentVC.finishedLoginProcess(loginStatus: true)
				})
			}
		}
		else {
			showAlert(message: "The entered OTP did not match our records.")
		}
	}
	
	func showAlert(message: String) {
		let parentVC = parent as! EnterFreejNavController
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (UIAlertAction) in self.generateOTP()}))
		alert.addAction(UIAlertAction(title: "Cancel Login", style: .default, handler: { (UIAlertAction) in
			parentVC.finishedLoginProcess(loginStatus: false)
		}))
		self.present(alert, animated: true)
	}
    
	func generateOTP() {
		correctOtp = "\(Int.random(in: 1000...9999))"
		otpGenerationTime = Date()
		
		NetworkManager.sendOTP(toEmail: (DataModel.currentUser?.kfupmID!)! + "@kfupm.edu.sa", otp: correctOtp) { (hasSent) in
			if(!hasSent) {
				self.showAlert(message: "The application encountered an error while sending the OTP.")
			}
		}
	}
}
