//
//  ActivitiesViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 10/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class ActivitesVC: UIViewController {
    lazy var tableView = UITableView()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}

extension ActivitesVC: UITableViewDataSource, UITableViewDelegate {
	func configureTableView() {
		tableView.delegate = self
		tableView.dataSource = self
	}
	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
	
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell") as! RequestCell
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MaintenanceCell") as! MaintenanceCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesCell") as! ServicesCell
            return cell
        }
    }
}



