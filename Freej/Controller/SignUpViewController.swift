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
		sendKFUPMIDToValidateScreen()
    }
	
	func newUserHasValidated() {
		NetworkManager.signUpUser(kfupmIDTF.text!, fNameTF.text!, lNameTF.text!, bNoTF.text!) { (wasSuccess) in
			let parentVC = self.parent as! EnterFreejNavController
			if(wasSuccess) {
				parentVC.dismiss(loginStatus: true)
			}
			else {
				self.showAlert(message: "Error while signing up a new account. Please try again later.")
			}
		}
	}
	
	func sendKFUPMIDToValidateScreen() {
		performSegue(withIdentifier: "toValidateCodeFromSignUp", sender: self)
	}
	
	func showAlert(message: String) {
		let parentVC = parent as! EnterFreejNavController
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		
		alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (UIAlertAction) in parentVC.popViewController(animated: true)}))
		
		self.present(alert, animated: true)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.destination is ValidateViewController) {
			let destinationVC = segue.destination as! ValidateViewController
			destinationVC.kfupmID = kfupmID
			destinationVC.newUserValidationDelegate = self
		}
	}
}
