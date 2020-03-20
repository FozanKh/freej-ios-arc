//
//  ValidateViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 20/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

protocol LoginDelegate {
    func didFinishLogInProcess(loginStatus: Bool)
}

class ValidateViewController: UIViewController {
    @IBOutlet weak var kfupmIDLabel: UILabel!
    var kfupmID: String!
    
    var loginDelegate: LoginDelegate?
    
    var loginStatus = true
    
    override func loadView() {
        super.loadView()
        kfupmIDLabel.text = kfupmID
    }
}
