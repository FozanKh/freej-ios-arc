//
//  EnterFreejNavController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 20/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class EnterFreejNavController: UINavigationController {
    override func loadView() {
        super.loadView()
		DataModel.userIsSignedUp() ? showValidationScreen() : showSignUpScreen()
    }
    
    func showValidationScreen() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ValidateViewController") as! ValidateViewController
        pushViewController(vc, animated: false)
    }
    
    func showSignUpScreen() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        pushViewController(vc, animated: false)
    }
}
