//
//  ValidateViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 20/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import MessageUI

class ValidateViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var kfupmIDLabel: UILabel!
    var kfupmID: String!
    var loginStatus = true
    var correctPIN: String?
    @IBOutlet weak var validationCodeTF: UITextField!
    
    override func loadView() {
        super.loadView()
        kfupmIDLabel.text = kfupmID
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showMailComposer()
    }
    
    func showMailComposer() {
        guard MFMailComposeViewController.canSendMail() else {
            print("sfgdfdfdfdf")
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["khd.khamis@gmail.com"])
        composer.setSubject("Your code")
        
        correctPIN = "\(Int.random(in: 1000...9999))"
        
        composer.setMessageBody(correctPIN!, isHTML: false)
        
        present(composer, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        if(validationCodeTF.text == correctPIN) {
            let parentNavController = self.parent as! EnterFreejNavController
            parentNavController.dismiss(loginStatus: self.loginStatus)
        }
    }
}
