//
//  SignUpViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 20/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var kfupmIDTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var buildingNumTF: UITextField!
    var kfupmID: String!
    
    override func loadView() {
        super.loadView()
        kfupmIDTF.text = kfupmID
    }
	
    @IBAction func signUpBtn(_ sender: Any) {
        NetworkManager.signUpUser(kfupmIDTF.text!, firstNameTF.text!, lastNameTF.text!, buildingNumTF.text!) { (status) in
            if(status == true) {
                self.performSegue(withIdentifier: "toValidateCodeFromSignUp", sender: self)
            }
        }
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.destination is ValidateViewController) {
			(segue.destination as! ValidateViewController).kfupmID = kfupmID
		}
	}
}
