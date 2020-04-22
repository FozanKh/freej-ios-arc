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
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		setViewControllerVariables()
		let fetchResult = DataModel.fetch(entity: .student)
		if(fetchResult != nil && fetchResult!.count > 0) {
			let user = fetchResult![0] as! Student
			if user.isLoggedIn {
				DataModel.currentUser = user 
				loadMainVC()
			} else {
				loadWelcomeVC()
			}
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
		DataModel.clear(entity: .student)
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
