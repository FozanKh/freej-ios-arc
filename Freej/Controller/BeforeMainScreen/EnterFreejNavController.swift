//
//  EnterFreejNavController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 20/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

protocol LoginDelegate {
    func didFinishLogInProcess(loginStatus: Bool)
}

class EnterFreejNavController: UINavigationController {
    var isSignedUp: Bool!
    var kfupmID: String! //this will be verified in the welcomeVC so it is safe to keep it (!)
    
    var loginDelegate: LoginDelegate?
    
    override func loadView() {
        super.loadView()
        isSignedUp ? showValidationScreen() : showSignUpScreen()
    }
    
    func dismiss(loginStatus: Bool) {
        dismiss(animated: true)
        loginDelegate?.didFinishLogInProcess(loginStatus: loginStatus)
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
