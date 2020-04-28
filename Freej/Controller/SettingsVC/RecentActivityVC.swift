//
//  RecentActivityVC.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 28/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class RecentActivityVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
	let tableView = UITableView()
	
	override func loadView() {
		super.loadView()
		configureTableView()
	}
	
	func configureTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		title = "Recent Activity"
		view.addSubview(tableView)
		//		navigationController?.navigationBar.subviews[1].semanticContentAttribute = .forceRightToLeft
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		tableView.backgroundColor = .systemGroupedBackground
		let test = UIView()
		tableView.tableFooterView = test
		tableView.sectionFooterHeight = CGFloat(20.0)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
}
