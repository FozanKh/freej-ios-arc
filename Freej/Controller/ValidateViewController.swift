//
//  ValidateViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 20/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import MessageUI

class ValidateViewController: UIViewController {
    @IBOutlet weak var kfupmIDLabel: UILabel!
    var kfupmID: String!
    var loginStatus = true
    var correctPIN: String?
	var otp: String!
	
    @IBOutlet weak var validationCodeTF: UITextField!
    
    override func loadView() {
        super.loadView()
        kfupmIDLabel.text = kfupmID
		otp = generateOTP()
		sendCodeToEmail(email: kfupmID + "@kfupm.edu.sa", otp: otp)
    }
    
	func sendCodeToEmail(email: String, otp: String) {
		
	}
	
	func generateOTP() -> String {
		return "\(Int.random(in: 1000...9999))"
	}
    
    @IBAction func loginBtn(_ sender: Any) {
        if(validationCodeTF.text == correctPIN) {
            let parentNavController = self.parent as! EnterFreejNavController
            parentNavController.dismiss(loginStatus: self.loginStatus)

        }
    }
}
