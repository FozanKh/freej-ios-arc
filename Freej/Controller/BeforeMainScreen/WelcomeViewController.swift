//
//  WelcomeViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 13/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import JGProgressHUD

class WelcomeViewController: UIViewController {
	
	//This pod is temporary to show database connection
    let progressManager = JGProgressHUD()
    @IBOutlet weak var noInternetLabel: UILabel!
    @IBOutlet weak var kfupmIDTF: UITextField!
    @IBOutlet weak var enterFreejBtn: UIButton!
	
	//MARK:- User Login Methods
	@IBAction func enterFreejBtn(_ sender: Any) {
		progressManager.show(in: self.view)
		NetworkManager.getStudent(kfupmID: kfupmIDTF.text!) { (userJSON) in
			//userJSON could be an actual user in the databse or simply nil.
			
			self.progressManager.dismiss(animated: true)
			if(userJSON != nil) {
				//At this point, userJSON is a fully signedup user in the database
				//And they will be initialized as a signedUpUser in the DataModel.
				//The user will not be save to the persistent data model, (because only logged-in users are)
				//Will go to login page
				DataModel.setSignedUpUser(userJSON: userJSON!, saveToPersistent: false)
			}
			else {
				//At this point, userJSON is not signedup in the database.
				//Therefore, a partial unsignedup user is going to be created with ONLY KFUPM ID
				//The user will not be save to the persistent data model, (because only logged-in users are)
				//Will go to signup page
				DataModel.setUnSignedUpUser(kfupmID: self.kfupmIDTF.text!, saveToPersistent: false)
			}
			self.performSegue(withIdentifier: "toEnterFreej", sender: self)
		}
	}
	
	//MARK:- Accessing MainVC
	//This method will initialize the completion handler variable in EnterFreejNavController
	//EnterFreejNavController will call this handler whenever a login process is completed with (Bool)
	//This handler is NOT called by this class
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.destination is EnterFreejNavController) {
			let destVC = segue.destination as! EnterFreejNavController
			destVC.loginProcessCompletionHandler = { status in
				if(status == true) {
					self.performSegue(withIdentifier: "toMainVC", sender: self)
				}
			}
		}
	}
	
	//MARK:- Internet Reachability Methods
	func setInternetReachabilityObserver() {
		NotificationCenter.default.addObserver(self, selector: #selector(onDidChangeInternetStatus(_:)), name: NetworkManager.internetStatusNName, object: nil)
	}
	
    @objc func onDidChangeInternetStatus(_ notification: Notification) {
		let internetStatus = notification.userInfo?["Status"] as! Bool
		noInternetLabel.isHidden = internetStatus
		enterFreejBtn.isEnabled = internetStatus
		internetStatus ? (enterFreejBtn.backgroundColor = .systemIndigo) : (enterFreejBtn.backgroundColor = .darkGray)
    }
}
