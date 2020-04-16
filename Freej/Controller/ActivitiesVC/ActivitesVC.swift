//
//  ActivitiesViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 10/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class ActivitesVC: UIViewController {
	var tableView = UITableView()
	var screenHeight: CGFloat!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		registerCells()
		setScreenHeight()
        configureTableView()
    }
	
	func setScreenHeight() {
		let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
		let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
		
		screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height - self.navigationController!.navigationBar.frame.size.height - 80
		screenHeight -= statusBarHeight
	}
	
	func registerCells() {
		tableView.register(UINib(nibName: "ActivityTypeCell", bundle: nil), forCellReuseIdentifier: "ActivityTypeCell")
	}
}

extension ActivitesVC: UITableViewDataSource, UITableViewDelegate {
	func configureTableView() {
		title = "Activities"
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		tableView.backgroundColor = .systemGroupedBackground
		let footer = UIView()
		tableView.tableFooterView = footer
		tableView.rowHeight = screenHeight / CGFloat(ActivityType.activityTypesArray!.count)
	}
	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return screenHeight / CGFloat(ActivityType.activityTypesArray!.count)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return ActivityType.activityTypesArray!.count
	}
	
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityTypeCell")! as! ActivityTypeCell
		cell.selectionStyle = .none
		
		if(indexPath.section < ActivityType.activityTypesArray!.count && ActivityType.activityTypesArray != nil) {
			cell.acTID = ActivityType.activityTypesArray![indexPath.section].acTID
		}
		cell.setupCell()
		return cell
    }
}
