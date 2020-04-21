//
//  EnterFreejNavController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 20/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class EnterFreejNavController: UINavigationController {
	//This completion handler will be set by WelcomeViewController
	var loginProcessCompletionHandler: ((Bool) -> ())?
	
    override func loadView() {
        super.loadView()
		//At this point, there must be a user in DataModel class (look at enterFreejBtn implementation)
		DataModel.userIsSignedUp() ? showValidationScreen() : showSignUpScreen()
    }
	
	//This method is called by (ValidationViewController) which dismisses the VC and calls the completion handeler
	//The completion handler is set by the WelcomeViewController
	func finishedLoginProcess(loginStatus: Bool) {
		self.dismiss(animated: true)
		loginProcessCompletionHandler?(loginStatus)
	}
    
	//MARK:- Push Suitable View Controller Methods
    func showValidationScreen() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ValidateViewController") as! ValidateViewController
        pushViewController(vc, animated: false)
    }
    
    func showSignUpScreen() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        pushViewController(vc, animated: false)
    }
}
