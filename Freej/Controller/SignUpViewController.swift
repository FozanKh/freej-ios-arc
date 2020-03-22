//
//  SignUpViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 20/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, NewUserValidationProtocol {
    @IBOutlet weak var kfupmIDTF: UITextField!
    @IBOutlet weak var fNameTF: UITextField!
    @IBOutlet weak var lNameTF: UITextField!
    @IBOutlet weak var bNoTF: UITextField!
    var kfupmID: String!
    
    override func loadView() {
        super.loadView()
        kfupmIDTF.text = kfupmID
    }
	
    @IBAction func signUpBtn(_ sender: Any) {
		performSegue(withIdentifier: "toValidateCodeFromSignUp", sender: self)
    }
	
	func newUserHasValidated() {
		NetworkManager.signUpUser(kfupmIDTF.text!, firstNameTF.text!, lastNameTF.text!, buildingNumTF.text!)
		NetworkManager.signUpUser(kfupmIDTF.text!, firstNameTF.te, <#T##lastName: String##String#>, <#T##bno: String##String#>, completion: <#T##(Bool) -> ()#>)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.destination is ValidateViewController) {
			let destinationVC = segue.destination as! ValidateViewController
			destinationVC.kfupmID = kfupmID
			destinationVC.newUserValidationDelegate = self
		}
	}
}
