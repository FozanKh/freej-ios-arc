//
//  SignUpViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 13/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class SignUpView: UIViewController {
    
    var kfupmID: String?
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var bno: UITextField!
    
    @IBAction func signUpBtn(_ sender: Any) {
        NetworkManager.signUpUser(kfupmID!, firstName.text!, lastName.text!, bno.text!) { (response) in
            //This gets executed after their signup
        }
    }
}
