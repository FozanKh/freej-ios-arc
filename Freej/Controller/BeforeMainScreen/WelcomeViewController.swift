//
//  WelcomeViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 13/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import JGProgressHUD

class WelcomeViewController: UIViewController, LoginDelegate {
    let progressManager = JGProgressHUD()
	var isSignedUp: Bool!
	
    @IBOutlet weak var noInternetLabel: UILabel!
    @IBOutlet weak var kfupmIDTF: UITextField!
    @IBOutlet weak var enterFreejBtn: UIButton!

    override func loadView() {
        super.loadView()
		NotificationCenter.default.addObserver(self, selector: #selector(onDidChangeInternetStatus(_:)), name: NetworkManager.internetStatusNName, object: nil)
    }
	
	@IBAction func enterFreejBtn(_ sender: Any) {
		progressManager.show(in: self.view)
		NetworkManager.isSignedUp(kfupmID: kfupmIDTF.text!) { (signUpStatus) in
			self.isSignedUp = signUpStatus
			self.progressManager.dismiss(animated: true)
			
			self.performSegue(withIdentifier: "toEnterFreej", sender: self)
		}
	}
    
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.destination is EnterFreejNavController) {
			let destinationVC = segue.destination as! EnterFreejNavController
			destinationVC.isSignedUp = isSignedUp
			destinationVC.kfupmID = kfupmIDTF.text!
			destinationVC.loginDelegate = self
		}
	}
	
    @objc func onDidChangeInternetStatus(_ notification: Notification) {
		let internetStatus = notification.userInfo?["Status"] as! Bool
		noInternetLabel.isHidden = internetStatus
		enterFreejBtn.isEnabled = internetStatus
		internetStatus ? (enterFreejBtn.backgroundColor = .systemIndigo) : (enterFreejBtn.backgroundColor = .darkGray)
    }
    
    func didFinishLogInProcess(loginStatus: Bool) {
        if(loginStatus) {
			NetworkManager.getStudent(kfupmID: kfupmIDTF.text!) { (userInfo, requestStatus) in
				if(requestStatus == true) {
					DataModel.setCurrentUser(userJSON: userInfo[0])
					self.performSegue(withIdentifier: "toMainVC", sender: self)
				}
				else {
					self.showAlert(message: "Error while logging into the system.")
				}
			}
		}
	}
	
	func showAlert(message: String) {
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
		self.present(alert, animated: true)
	}
}
