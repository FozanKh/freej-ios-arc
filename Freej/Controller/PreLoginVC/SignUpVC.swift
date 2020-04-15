//
//  SignUpViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 20/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

/*
	Upon clicking on sign up button, the user will not immediately added to the database.
	The user must initially verify his identity by entering the correct code sent to their email.
*/

import UIKit

class SignUpVC: UIViewController {
	@IBOutlet weak var kfupmIDTF: UITextField! {
		didSet {
			kfupmIDTF.textColor = .gray
			kfupmIDTF.text = DataModel.currentUser!.kfupmID
		}
	}
	
    @IBOutlet weak var fNameTF: UITextField!
    @IBOutlet weak var lNameTF: UITextField!
    @IBOutlet weak var bNoTF: UITextField!
	
	//MARK:- Segue Methods
    @IBAction func signUpBtn(_ sender: Any) {
		//This is to send the KFUPM ID to the ValidateViewController
		DataModel.currentUser!.fName = fNameTF.text!
		DataModel.currentUser!.lName = lNameTF.text!
		DataModel.currentUser!.bno = bNoTF.text!
		performSegue(withIdentifier: "toValidateCodeFromSignUp", sender: self)
    }
}
