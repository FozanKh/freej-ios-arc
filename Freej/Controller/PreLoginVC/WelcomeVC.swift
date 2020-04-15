//
//  WelcomeViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 13/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import JGProgressHUD

class WelcomeVC: UIViewController, DataModelProtocol {
	//This pod is temporary to show database connection
    let progressManager = JGProgressHUD()
    @IBOutlet weak var noInternetLabel: UILabel!
    @IBOutlet weak var kfupmIDTF: UITextField!
    @IBOutlet weak var enterFreejBtn: UIButton!
	
    
    override func loadView() {
        super.loadView()
		DataModel.dataModelDelegate = self
        setInternetReachabilityObserver()
    }
    
	//MARK:- User Login Methods
	@IBAction func enterFreejBtn(_ sender: Any) {
		progressManager.show(in: self.view)
		NetworkManager.getStudent(kfupmID: kfupmIDTF.text!) { (student) in
			self.progressManager.dismiss(animated: true)
			if(student != nil) {
				DataModel.setCurrentStudent(student: student!, saveToPersistent: false)
				self.performSegue(withIdentifier: "toValidateVC", sender: self)
			}
			else {
				DataModel.instantiateEmptyStudent()
				DataModel.currentUser!.kfupmID = self.kfupmIDTF.text!
				self.performSegue(withIdentifier: "toSignUpVC", sender: self)
			}
		}
	}
	
	//MARK:- Accessing MainVC
	//This method will be called when a user is saved to the persistent data base to be enrolled to the main vc
	func userHasValidated() {
		performSegue(withIdentifier: "toMainVC", sender: self)
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
