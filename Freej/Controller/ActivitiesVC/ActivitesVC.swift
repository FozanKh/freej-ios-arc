//
//  ActivitiesViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 10/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class ActivitesVC: UIViewController, ActivityTypeCellProtocol {
	var tableView = UITableView()
	var screenHeight: CGFloat!
	let refreshConroller = UIRefreshControl()

    override func viewDidLoad() {
		super.viewDidLoad()
		registerCells()
		setScreenHeight()
        configureTableView()
		addRefreshControl()
    }
	
	func didPressAddActivity(activityType: ActivityType) {
		performSegue(withIdentifier: "toAddActivityVC", sender: activityType)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is AddActivityVC {
			let dest = segue.destination as! AddActivityVC
			dest.activityType = sender as? ActivityType
		}
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
		tableView.delegate = self
		tableView.dataSource = self
		title = "Activities"
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
		tableView.rowHeight = screenHeight / CGFloat(DataModel.activityTypesArray?.count ?? 3)
	}
	
	func addRefreshControl() {
		refreshConroller.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
		refreshConroller.addTarget(self, action: #selector(refreshActivitiesList), for: .valueChanged)
		tableView.addSubview(refreshConroller)
	}
	
	@objc func refreshActivitiesList() {
		DataModel.loadSessionData {
			self.refreshConroller.endRefreshing()
			self.tableView.reloadData()
			print(DataModel.activityTypesArray)
		}
	}
	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return screenHeight / CGFloat(DataModel.activityTypesArray?.count ?? 3)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return DataModel.activityTypesArray?.count ?? 3
	}
	
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityTypeCell")! as! ActivityTypeCell
		cell.selectionStyle = .none
		
		if DataModel.activityTypesArray != nil && indexPath.section < DataModel.activityTypesArray!.count {
			cell.activityType = DataModel.activityTypesArray![indexPath.section]
		}
		
		cell.activityTypeCellDelegate = self
		
		cell.setupCell()
		return cell
    }
}
