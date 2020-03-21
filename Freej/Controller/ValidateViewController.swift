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
    @IBOutlet weak var kfupmIDLabel: UILabel!
    var kfupmID: String!
	var loginStatus: Bool!
    var correctPIN: String?
	var otp: String!
	var otpGenerationTime: Date!
	
    @IBOutlet weak var validationCodeTF: UITextField!
    
    override func loadView() {
        super.loadView()
        kfupmIDLabel.text = kfupmID
		
		generateOTP {
			//After the successful generation of OTP, the code gets sent to the provided email
			sendCodeToEmail(email: kfupmID + "@kfupm.edu.sa", otp: otp)
		}
    }
    
	func sendCodeToEmail(email: String, otp: String) {
		let params = ["to" : email, "otp" : otp]
		Alamofire.request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)
	}
	
	func generateOTP(completion: () -> ()) {
		otp = "\(Int.random(in: 1000...9999))"
		otpGenerationTime = Date()
		completion()
	}
    
    @IBAction func loginBtn(_ sender: Any) {
        if(validationCodeTF.text == correctPIN) {
            let parentNavController = self.parent as! EnterFreejNavController
            parentNavController.dismiss(loginStatus: self.loginStatus)

        }
    }
}
