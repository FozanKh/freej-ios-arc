//
//  SettingsViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 10/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import SafariServices

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
	lazy var tableView = UITableView(frame: view.frame, style: .insetGrouped)
    var whatsappLink : String = ""
    
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		configureTableView()
		view.backgroundColor = .systemGray5
        getWhatsappLink {
                       print(self.whatsappLink)
                   }
	}
    
    func showSafariVC(for url: String){
        guard let url = URL(string: url) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }

    func getWhatsappLink(completion: @escaping () -> ()){
        NetworkManager.jsonRequest(type: .whatsAppLink, params: ["BNo" : DataModel.currentUser!.bno!]) { (whatsappJSON) in
            if (whatsappJSON == nil) {
                self.whatsappLink = ""
                completion()
            }
            else {
                self.whatsappLink = whatsappJSON!.array![0]["GroupURL"].stringValue
                //print(self.whatsappLink)
                completion()
            }
        }
    }
	
	func configureTableView() {
		title = "Settings"
		
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
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let segueID = SettingsData.sections[indexPath.section][indexPath.row].cellSegueID
		if(segueID == "toLogOut") {
			DataModel.clearCurrentUser()
			parent?.navigationController?.popToRootViewController(animated: true)
        } else if(segueID == "toWhatsappGroup") {
            showSafariVC(for: whatsappLink)
        }
		else {
			performSegue(withIdentifier: segueID, sender: self)
		}
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return SettingsData.sections[section].count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return SettingsData.sections.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = (SettingsData.sections[indexPath.section][indexPath.row]).cellTitle
		cell.imageView?.image = (SettingsData.sections[indexPath.section][indexPath.row]).getImage()
		cell.accessoryType = .disclosureIndicator
		
		indexPath.section == 2 ? (cell.tintColor = .red) : (cell.tintColor = .systemBlue)
		return cell
	}
}
