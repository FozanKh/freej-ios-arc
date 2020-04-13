//
//  AddAnnouncement.swift
//  Freej
//
//  Created by khaled khamis on 01/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import UIKit

class AddAnnouncementVC : UIViewController, UITextViewDelegate {
    @IBOutlet weak var ancmtTypeTF: UITextField!
	@IBOutlet weak var ancmtDescrp: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
    }
    
	@IBAction func addButton(_ sender: UIButton) {
		addAnnouncement()
	}
	
	func addAnnouncement() {
		var atID = ""
		switch ancmtTypeTF.text! {
		case "General":
			atID = "1"
		case "Specific":
			atID = "2"
		default:
			atID = "3"
		}
		
		NetworkManager.postAnnouncement(atID, DataModel.currentUser!.userID!, ancmtTypeTF.text!, ancmtDescrp.text!) { (sent) in
			sent ? print("Sent successfully") : print("Failed")
		}
		self.dismiss(animated: true, completion: nil)
	}
	
	func configureTextView() {
		ancmtDescrp.delegate = self
		ancmtDescrp.layer.borderWidth = 1
		ancmtDescrp.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		ancmtDescrp.layer.cornerRadius = 5
	}

	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if(text == "\n") {
			textView.resignFirstResponder()
			addAnnouncement()
			return true
		}
		return true
	}
}
