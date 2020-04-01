//
//  AddAnnouncement.swift
//  Freej
//
//  Created by khaled khamis on 01/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import UIKit

class AddAnnouncement : UIViewController {
    
    @IBOutlet weak var contentField: UITextField!
    @IBOutlet weak var type: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        addAnnouncement(antID: "1", userID: "2", title: type.text!, content: contentField.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
