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
	Therefore, as seen in the implementation, upon clicking signup, the KFUPM ID is sent to the next VC.
	The newUserHasValidated delegate method will be called by the ValidateViewController upon the successful entering of the OTP.
*/
import UIKit

class SignUpViewController: UIViewController, NewUserLoginProtocol {
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
		performSegue(withIdentifier: "toValidateCodeFromSignUp", sender: self)
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.destination is ValidateViewController) {
			let destVC = segue.destination as! ValidateViewController
			destVC.newUserLoginDelegate = self
		}
	}
	
	//This delegate method will get called by the ValidationController upon the SUCCESS of OTP code validation.
	//Since the user in DataModel.currentUser is not complete (i.e. only has KFUPM ID)
	//check enterFreejBtn implementation for further explanation in WelcomeViewController.
	//The user will be added to the database at this point (after corrct OTP)
	//The user will be re-downloaded from the Database (we need this to save his user id in the object)
	//And after completion, the handler will be called with either true or false to the ValidateViewControleler
	//ValidateViewController will then based on the returned result, dismiss the view and login the user if (true)
	func newUserHasValidated(completion: @escaping (Bool, String?) -> ()) {
		NetworkManager.signUpUser(kfupmIDTF.text!, fNameTF.text!, lNameTF.text!, bNoTF.text!) { (signUpStatus) in
			if(signUpStatus == true) {
				
				NetworkManager.getStudent(kfupmID: self.kfupmIDTF.text!) { (userInfo) in
					if(userInfo != nil) {
						completion(true, nil)
						//Save to persistent because the user is successfully logged-in
                        
						DataModel.setSignedUpUser(userJSON: userInfo!, saveToPersistent: true)
					}
					else {
						//Clear from persistent, and local memory because login process was failed.
						DataModel.clearCurrentUser()
						completion(false, "Error: Could not login user.")
					}
				}
				
			}
			else {
				completion(false, "Error: Could not sign up user.")
			}
		}
	}
	
	//MARK:- Misc. Methods
	func showAlert(message: String) {
		let parentVC = parent as! EnterFreejNavController
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (UIAlertAction) in parentVC.popViewController(animated: true)}))
		self.present(alert, animated: true)
	}
}
