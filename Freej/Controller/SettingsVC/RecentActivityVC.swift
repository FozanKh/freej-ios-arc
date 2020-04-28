//
//  RecentActivityVC.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 28/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class RecentActivityVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
	lazy var tableView = UITableView(frame: view.frame, style: .insetGrouped)
	var screenHeight: CGFloat!
	
	override func loadView() {
		super.loadView()
		setScreenHeight()
		configureTableView()
	}
	
	func setScreenHeight() {
		let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
		let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
		
		screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height - self.navigationController!.navigationBar.frame.size.height - 80
		screenHeight -= statusBarHeight
	}
	
	func configureTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UINib(nibName: "ActivityCell", bundle: nil), forCellReuseIdentifier: "ActivityCell")
		title = "Recent Activity"
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		tableView.backgroundColor = .systemGroupedBackground
		tableView.rowHeight = screenHeight / 4
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return DataModel.activityTypesArray?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		view.tintColor = .systemGroupedBackground
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return DataModel.activityTypesArray?[section].typeName ?? "Error"
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return DataModel.activityTypesArray?[section].studentActivities?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell") as! ActivityCell
		cell.activity = (DataModel.activityTypesArray?[indexPath.section].studentActivities?.allObjects as! [Activity])[indexPath.row]
		
		return cell
	}
}
