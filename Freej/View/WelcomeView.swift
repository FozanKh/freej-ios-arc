//
//  WelcomeView.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 13/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import SVProgressHUD

class WelcomeView: UIViewController {
    
    @IBOutlet weak var kfupmIDTF: UITextField!
    
    @IBAction func enterFreejBtn(_ sender: Any) {
        SVProgressHUD.show()
        Network.isSignedUp(kfupmID: kfupmIDTF.text!) { (Bool) in
            SVProgressHUD.dismiss()
            //get if already a user or not
            //dismiss svprogresshud
            //if user login
            //if not sign up
        }
        
    }
    
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
