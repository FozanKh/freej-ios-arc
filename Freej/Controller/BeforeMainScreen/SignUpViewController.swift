//
//  SignUpViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 20/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, NewUserLoginProtocol {
    @IBOutlet weak var kfupmIDTF: UITextField!
    @IBOutlet weak var fNameTF: UITextField!
    @IBOutlet weak var lNameTF: UITextField!
    @IBOutlet weak var bNoTF: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		kfupmIDTF.textColor = .gray
		kfupmIDTF.text = DataModel.currentUser!.kfupmID
	}
	
    @IBAction func signUpBtn(_ sender: Any) {
		sendKFUPMIDToValidateScreen()
		
    }
	
	func sendKFUPMIDToValidateScreen() {
		performSegue(withIdentifier: "toValidateCodeFromSignUp", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.destination is ValidateViewController) {
			let destVC = segue.destination as! ValidateViewController
			destVC.newUserLoginDelegate = self
		}
	}
	
	func newUserHasValidated(completion: @escaping (Bool) -> ()) {
		NetworkManager.signUpUser(kfupmIDTF.text!, fNameTF.text!, lNameTF.text!, bNoTF.text!) { (signUpStatus) in
			if(signUpStatus == true) {
				
				NetworkManager.getStudent(kfupmID: self.kfupmIDTF.text!) { (userInfo) in
					if(userInfo != nil) {
						completion(true)
						DataModel.setSignedUpUser(userJSON: userInfo!, saveToPersistent: true)
					}
					else {
						self.showAlert(message: "Error: Could not login user.")
						completion(false)
					}
				}
				
			}
			else {
				self.showAlert(message: "Error: Could not sign up user.")
				completion(false)
			}
		}
	}
	
	func showAlert(message: String) {
		let parentVC = parent as! EnterFreejNavController
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (UIAlertAction) in parentVC.popViewController(animated: true)}))
		self.present(alert, animated: true)
	}
}
