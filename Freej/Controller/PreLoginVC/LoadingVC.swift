//
//  LoadingVC.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 18/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class LoadingVC: UIViewController {
	var mainVC: UIViewController?
	var welcVC: UIViewController?
	var vcToBeShown: UIViewController?

	override func loadView() {
		super.loadView()
		setViewControllerVariables()
		if(DataModel.userWasLoggedIn()) {
			let user = DataModel.getStudentFromPersistentDM()
			if(user != nil) {
				DataModel.setCurrentStudent(student: user!, saveToPersistent: true)
				loadMainVC()
			}
			else {loadWelcomeVC()}
		}
		else {loadWelcomeVC()}
	}
	
	func loadMainVC() {
		DataModel.loadSessionData {
			self.vcToBeShown = self.mainVC
			self.performSegue(withIdentifier: "toRootNC", sender: self)
		}
	}
	
	func loadWelcomeVC() {
		DataModel.clearCurrentUser()
		vcToBeShown = welcVC
		self.performSegue(withIdentifier: "toRootNC", sender: self)
	}
	
	func setViewControllerVariables() {
		mainVC = storyboard!.instantiateViewController(withIdentifier: "MainVC")
		welcVC = storyboard!.instantiateViewController(withIdentifier: "WelcomeVC")
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destVC = segue.destination as! UINavigationController
		destVC.pushViewController(vcToBeShown!, animated: false)
	}
}
