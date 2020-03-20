//
//  EnterFreejNavController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 20/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class EnterFreejNavController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.performSegue(withIdentifier: "toValidateCode", sender: self)
    }
}
