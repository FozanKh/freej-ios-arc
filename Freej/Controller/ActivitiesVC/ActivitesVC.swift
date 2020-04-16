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
	var screenHeight: CGFloat!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setScreenHeight()
        configureTableView()
    }
	
	func setScreenHeight() {
		screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height - self.navigationController!.navigationBar.frame.size.height - 80
		if(UIDevice().name.contains("X") || UIDevice().name.contains("11")) {
			screenHeight! -= 50
		}
	}
}

extension ActivitesVC: UITableViewDataSource, UITableViewDelegate {
	func configureTableView() {
		title = "Activities"
		tableView.delegate = self
		tableView.dataSource = self
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		tableView.backgroundColor = .systemGroupedBackground
		let footer = UIView()
		tableView.tableFooterView = footer
		tableView.rowHeight = screenHeight / 3
	}
	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell") as! RequestCell
//            return cell
//        } else if indexPath.row == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MaintenanceCell") as! MaintenanceCell
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesCell") as! ServicesCell
//            return cell
//        }
		return UITableViewCell()
    }
}



