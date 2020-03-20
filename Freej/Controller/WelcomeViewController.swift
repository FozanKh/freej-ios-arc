//
//  WelcomeViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 13/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import JGProgressHUD

class WelcomeViewController: UIViewController {
    let progressManager = JGProgressHUD()
    @IBOutlet weak var noInternetLabel: UILabel!
    @IBOutlet weak var kfupmIDTF: UITextField!
    @IBOutlet weak var enterFreejBtn: UIButton!
    
    override func loadView() {
        super.loadView()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidChangeInternetStatus(_:)), name: NetworkManager.internetStatusNName, object: nil)
    }
    
    @objc func onDidChangeInternetStatus(_ notification: Notification) {
        switch notification.userInfo?["Status"] as? Bool {
        case true:
            noInternetLabel.alpha = 0
            enterFreejBtn.isEnabled = true
            enterFreejBtn.backgroundColor = .systemIndigo
            break
        default:
            noInternetLabel.alpha = 1
            enterFreejBtn.isEnabled = false
            enterFreejBtn.backgroundColor = .darkGray
            break
        }
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
                
            }
        }
        
        performSegue(withIdentifier: "toEnterFreeNavController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}
