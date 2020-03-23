//
//  ValidateViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 20/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import MessageUI
import Alamofire

protocol NewUserValidationProtocol {
	func newUserHasValidated()
}

class ValidateViewController: UIViewController {
    var kfupmID: String!
	var loginStatus: Bool!
	var correctOtp: String!
	var otpGenerationTime: Date!
	
	var newUserValidationDelegate: NewUserValidationProtocol?
	
    @IBOutlet weak var validationCodeTF: UITextField!
	
	
	override func loadView() {
		super.loadView()
		generateOTP()
	}
	
	@IBAction func loginButton(_ sender: Any) {
		let userEnteredOTP = validationCodeTF.text ?? "0"
		if(userEnteredOTP == correctOtp) {
			if(newUserValidationDelegate == nil) {
				(parent as! EnterFreejNavController).dismiss(loginStatus: true)
			} else {
				newUserValidationDelegate!.newUserHasValidated()
			}
		}
		else {
			showAlert(message: "The entered OTP did not match our records.")
		}
	}
	
	func showAlert(message: String) {
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (UIAlertAction) in self.generateOTP()}))
		alert.addAction(UIAlertAction(title: "Cancel Login", style: .default, handler: { (UIAlertAction) in
			(self.parent as! EnterFreejNavController).dismiss(loginStatus: false)
		}))
		self.present(alert, animated: true)
	}
    
	func generateOTP() {
		correctOtp = "\(Int.random(in: 1000...9999))"
		otpGenerationTime = Date()
		
		NetworkManager.sendOTP(toEmail: kfupmID + "@kfupm.edu.sa", otp: correctOtp) { (hasSent) in
			if(!hasSent) {
				self.showAlert(message: "The application encountered an error while sending the OTP.")
			}
		}
	}
}
