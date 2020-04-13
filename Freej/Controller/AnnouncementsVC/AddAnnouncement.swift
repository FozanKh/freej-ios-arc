//
//  AddAnnouncement.swift
//  Freej
//
//  Created by khaled khamis on 01/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import UIKit

class AddAnnouncement : UIViewController, UITextViewDelegate {
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var type: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentField.delegate = self
        contentField.layer.borderWidth = 1
        contentField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        contentField.layer.cornerRadius = 5
    }
    
    func addAnnouncement(antID : String, userID : String, title : String, content : String){
        NetworkManager.postAnnouncement(antID, userID, title, content) { (sent) in
            if (sent == true){
                print("Sent successfully")
            }else{
                print("Failed")
            }
        }
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        textFieldFunction()
        addAnnounce()
    }
    
    //Fix go buttong
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldFunction()
        type.endEditing(true)
        return true
    }
    
    func textFieldFunction() {
        type.endEditing(true)
    }
    
    func addAnnounce() {
        var atID = ""
        switch type.text! {
        case "General":
            atID = "1"
        case "Specific":
            atID = "2"
        default:
            atID = "3"
        }
        
        addAnnouncement(antID: atID, userID: DataModel.currentUser!.userID!, title: type.text!, content: contentField.text!)
        self.dismiss(animated: true, completion: nil)
        
    }
}
