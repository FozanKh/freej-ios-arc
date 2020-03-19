//
//  WelcomeView.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 13/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import JGProgressHUD

class WelcomeView: UIViewController {
    let progressManager = JGProgressHUD()
    
    @IBOutlet weak var kfupmIDTF: UITextField!
    
    override func loadView() {
        super.loadView()
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeInternetStatus(_:)), name: Notification.Name("didChangeInternetStatus"), object: nil)
    }
    
    @objc func didChangeInternetStatus(_ notification: Notification) {
        kfupmIDTF.text = notification.userInfo!["Status"] as! String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func enterFreejBtn(_ sender: Any) {
        progressManager.show(in: self.view)
        NetworkManager.isSignedUp(kfupmID: kfupmIDTF.text!) { (isSignedUp) in
            
            self.progressManager.dismiss(animated: true)
            if(isSignedUp) {
                //Login Comes Here
            }
            else {
                self.performSegue(withIdentifier: "signUpSegue", sender: self)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is SignUpView) {
            let vc = segue.destination as? SignUpView
            vc?.kfupmID = kfupmIDTF.text!
        }
    }
}
