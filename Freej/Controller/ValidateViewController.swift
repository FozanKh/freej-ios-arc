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

class ValidateViewController: UIViewController {
	
    var kfupmID: String!
	var loginStatus: Bool!
	var otp: String!
	var otpGenerationTime: Date!
	
    @IBOutlet weak var validationCodeTF: UITextField!
    
    override func loadView() {
        super.loadView()		
		generateOTP {
			//After the successful generation of OTP, the code gets sent to the provided email
			let status = NetworkManager.sendOTP(toEmail: kfupmID + "@kfupm.edu.sa", otp: otp)
			if(status == false) {
				showErrorSendingOTP()
			}
		}
    }
	
	@IBAction func loginButton(_ sender: Any) {
		let userEnteredOTP = validationCodeTF.text ?? "0"
		if(userEnteredOTP == otp) {
			(parent as! EnterFreejNavController).dismiss(loginStatus: true)
		}
	}
	
	func showErrorSendingOTP() {
		let alert = UIAlertController(title: "Error", message: "The application encountered an error while sending the OTP.", preferredStyle: .alert)
		
		alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (UIAlertAction) in
			self.generateOTP {
				let status = NetworkManager.sendOTP(toEmail: self.kfupmID + "@kfupm.edu.sa", otp: self.otp)
				if(!status) {
					self.showErrorSendingOTP()
				}
			}
		}))
		alert.addAction(UIAlertAction(title: "Cancel Login", style: .default, handler: { (UIAlertAction) in
			(self.parent as! EnterFreejNavController).dismiss(loginStatus: false)
		}))
		self.present(alert, animated: true)
	}
    
	func generateOTP(completion: () -> ()) {
		otp = "\(Int.random(in: 1000...9999))"
		otpGenerationTime = Date()
		completion()
	}
}
