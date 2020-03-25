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
    let progressManager = JGProgressHUD()
	
    @IBOutlet weak var noInternetLabel: UILabel!
    @IBOutlet weak var kfupmIDTF: UITextField!
    @IBOutlet weak var enterFreejBtn: UIButton!

    override func loadView() {
        super.loadView()
		NotificationCenter.default.addObserver(self, selector: #selector(onDidChangeInternetStatus(_:)), name: NetworkManager.internetStatusNName, object: nil)
    }
	
	@IBAction func enterFreejBtn(_ sender: Any) {
		progressManager.show(in: self.view)
		NetworkManager.getStudent(kfupmID: kfupmIDTF.text!) { (userJSON) in
			self.progressManager.dismiss(animated: true)
			if(userJSON != nil) {
				DataModel.setCurrentUser(userJSON: userJSON!, saveToPersistent: false)
			}
			else {
				DataModel.setIncompleteUser(kfupmID: self.kfupmIDTF.text!, saveToPersistent: false)
			}
			self.performSegue(withIdentifier: "toEnterFreej", sender: self)
		}
	}

    @objc func onDidChangeInternetStatus(_ notification: Notification) {
		let internetStatus = notification.userInfo?["Status"] as! Bool
		noInternetLabel.isHidden = internetStatus
		enterFreejBtn.isEnabled = internetStatus
		internetStatus ? (enterFreejBtn.backgroundColor = .systemIndigo) : (enterFreejBtn.backgroundColor = .darkGray)
    }
	
	func showAlert(message: String) {
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
		self.present(alert, animated: true)
	}
}
