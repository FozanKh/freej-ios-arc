//
//  LoadingVC.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 18/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class LoadingVC: UIViewController {
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		let fetchResult = DataModel.fetch(entity: .student)
		
		if(fetchResult != nil && fetchResult!.count > 0) {
			let fetchedUser = fetchResult![0] as! Student
			if fetchedUser.isLoggedIn {
				DataModel.currentUser = fetchedUser
				loadMainVC()
			} else {
				loadWelcomeVC()
			}
		}
		else {loadWelcomeVC()}
	}
	
	func loadMainVC() {
		let mainVC = storyboard!.instantiateViewController(withIdentifier: "MainVC")
		DataModel.loadSessionData {
			self.performSegue(withIdentifier: "toRootNC", sender: mainVC)
		}
	}
	
	func loadWelcomeVC() {
		let welcVC = storyboard!.instantiateViewController(withIdentifier: "WelcomeVC")
		DataModel.clear(entity: .student)
		DataModel.loadSessionData {
			self.performSegue(withIdentifier: "toRootNC", sender: welcVC)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destVC = segue.destination as! UINavigationController
		destVC.pushViewController(sender as! UIViewController, animated: false)
	}
}
