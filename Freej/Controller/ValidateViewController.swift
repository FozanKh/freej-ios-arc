//
//  ValidateViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 20/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class ValidateViewController: UIViewController {
    @IBOutlet weak var kfupmIDLabel: UILabel!
    var kfupmID: String!
    var loginStatus = true
    
    override func loadView() {
        super.loadView()
        kfupmIDLabel.text = kfupmID
    }
    
    @IBAction func loginBtn(_ sender: Any) {
//        let parentNavController = self.parent as! EnterFreejNavController
//        parentNavController.dismiss(loginStatus: self.loginStatus)
    }
}
