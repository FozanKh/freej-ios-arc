//
//  AddAnnouncement.swift
//  Freej
//
//  Created by khaled khamis on 01/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import UIKit

class AddAnnouncement : UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var type: UITextField!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentField.layer.borderWidth = 1
        contentField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        contentField.layer.cornerRadius = 5
    }
    
    func addAnnouncement(antID : String, userID : String, title : String, content : String){
        AnnouncementsViewController.postAnnouncement(antID, userID, title, content) { (sent) in
            if (sent == true){
                print("Sent successfully")
                
            }else{
                print("Faild")
            }
        }
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        textFeildFunction()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFeildFunction()
        return true
    }
    
    func textFeildFunction(){
        contentField.endEditing(true)
        addAnnounce()
    }
    
    func addAnnounce() {
        addAnnouncement(antID: "1", userID: "2", title: type.text!, content: contentField.text!)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}
