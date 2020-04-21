//
//  AnnouncementsViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 10/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import SwiftyJSON

class AnnouncementsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
	
    var ancmtsArray: [Announcement] = []
    var header: Announcement!
    var headerNumber = 1
    let refreshConroller = UIRefreshControl()
    
	@IBOutlet weak var addAncmtButton: UIButton!
	@IBAction func addAnnouncement(_ sender: UIButton) {
		performSegue(withIdentifier: "toAddAnnouncementVC", sender: self)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        //        header = announcements[headerNumber]
        //        announcements.remove(at: headerNumber)
		configureTableView()
		addRefreshControl()
        NetworkManager.getAnnouncements { (announcementsJSON) in
            self.displayAnnouncements(announcementsJSON)
        }
        setAmeenPrivileges()
    }
	
    func setAmeenPrivileges() {
        DataModel.currentUser?.isAmeen ?? false ? (addAncmtButton.isHidden = false) : (addAncmtButton.isHidden = true)
    }
    
    func addRefreshControl() {
        refreshConroller.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        refreshConroller.addTarget(self, action: #selector(refreshAncmtsList), for: .valueChanged)
        tableView.addSubview(refreshConroller)
    }
    
    @objc func refreshAncmtsList() {
        NetworkManager.getAnnouncements { (annoucementsJSON) in
            self.displayAnnouncements(annoucementsJSON)
            self.refreshConroller.endRefreshing()
        }
    }
	
	
	func displayAnnouncements(_ announcementsJSON: JSON?) {
        if let value = announcementsJSON {
            self.ancmtsArray.removeAll()
            for anItem in value.array! {
                self.ancmtsArray.append(Announcement(type: anItem["Title"].stringValue, content: anItem["Descrp"].stringValue))
				self.ancmtsArray.reverse()
            }
			//            print(self.announcements.count)
			self.tableView.reloadData()
        }
    }
}

//MARK:- Table View Controller Delegate Extension
extension AnnouncementsViewController: UITableViewDataSource, UITableViewDelegate {
	func configureTableView() {
		tableView.delegate = self
		tableView.dataSource = self
	}
	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ancmtsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let announcement = ancmtsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnnouncementCell") as! AnnouncementCell
        cell.setAnnouncement(announcement: announcement)
        
        switch cell.typeLabel.text {
        case "General":
            cell.mainLabel.textColor = #colorLiteral(red: 1, green: 0.5960784314, blue: 0.02745098039, alpha: 1)
            cell.typeLabel.textColor = #colorLiteral(red: 1, green: 0.5960784314, blue: 0.02745098039, alpha: 1)
            cell.icon.tintColor = #colorLiteral(red: 1, green: 0.5960784314, blue: 0.02745098039, alpha: 1)
        case "Specific":
            cell.mainLabel.textColor = #colorLiteral(red: 0.862745098, green: 0.3725490196, blue: 0.368627451, alpha: 1)
            cell.typeLabel.textColor = #colorLiteral(red: 0.862745098, green: 0.3725490196, blue: 0.368627451, alpha: 1)
            cell.icon.tintColor = #colorLiteral(red: 0.862745098, green: 0.3725490196, blue: 0.368627451, alpha: 1)
        default:
            cell.mainLabel.textColor = #colorLiteral(red: 0.003921568627, green: 0.6392156863, blue: 0.8039215686, alpha: 1)
            cell.typeLabel.textColor = #colorLiteral(red: 0.003921568627, green: 0.6392156863, blue: 0.8039215686, alpha: 1)
            cell.icon.tintColor = #colorLiteral(red: 0.003921568627, green: 0.6392156863, blue: 0.8039215686, alpha: 1)
        }
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        165
    //    }
    //
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView {
    //
    //
    //        let header = tableView.dequeueReusableCell(withIdentifier: "AnnouncementCell") as! AnnouncementCell
    //        header.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    //        header.mainLabel.textColor = #colorLiteral(red: 0.8736796379, green: 0.1468148232, blue: 0.08675638586, alpha: 1)
    //        header.typeLabel.textColor = #colorLiteral(red: 0.8736796379, green: 0.1468148232, blue: 0.08675638586, alpha: 1)
    //        header.icon.tintColor = #colorLiteral(red: 0.8736796379, green: 0.1468148232, blue: 0.08675638586, alpha: 1)
    //        header.setAnnouncement(announcement: self.header)
    //
    //        return header
    //    }
    
    
}
