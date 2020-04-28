//
//  SignUpViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 20/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

/*
	Upon clicking on sign up button, the user will not immediately added to the database.
	The user must initially verify his identity by entering the correct code sent to their email.
*/

import UIKit

class SignUpVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	override func loadView() {
		super.loadView()
		bnoPicker.delegate = self
		bnoPicker.dataSource = self
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return DataModel.buildings?.count ?? 0
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return DataModel.buildings?[row] ?? "Please Restart"
	}
	
	@IBOutlet weak var kfupmIDTF: UITextField! {
		didSet {
			kfupmIDTF.textColor = .gray
			kfupmIDTF.text = DataModel.currentUser!.kfupmID
		}
	}
	
    @IBOutlet weak var fNameTF: UITextField!
    @IBOutlet weak var lNameTF: UITextField!
	@IBOutlet weak var bnoPicker: UIPickerView!
	
	//MARK:- Segue Methods
    @IBAction func signUpBtn(_ sender: Any) {
		//This is to send the KFUPM ID to the ValidateViewController
		DataModel.currentUser!.fName = fNameTF.text!
		DataModel.currentUser!.lName = lNameTF.text!
		DataModel.currentUser!.bno = DataModel.buildings?[bnoPicker.selectedRow(inComponent: 0)]
		performSegue(withIdentifier: "toValidateCodeFromSignUp", sender: self)
    }
}
