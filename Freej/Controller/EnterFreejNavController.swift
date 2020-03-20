//
//  EnterFreejNavController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 20/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class EnterFreejNavController: UINavigationController {
    var isSignedUp: Bool!
    var kfupmID: String!
    
    override func loadView() {
        super.loadView()
        isSignedUp ? showValidationScreen() : showSignUpScreen()
    }
    
    func showSignUpScreen() {
        pushViewController(storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController, animated: false)
    }
    
    func showValidationScreen() {
        pushViewController(storyboard?.instantiateViewController(withIdentifier: "ValidateViewController") as! ValidateViewController, animated: false)
    }
}
