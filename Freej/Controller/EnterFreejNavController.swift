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
    
    func showValidationScreen() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ValidateViewController") as! ValidateViewController
        vc.kfupmID = self.kfupmID
        pushViewController(vc, animated: false)
    }
    
    func showSignUpScreen() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        vc.kfupmID = self.kfupmID
        pushViewController(vc, animated: false)
    }
}
