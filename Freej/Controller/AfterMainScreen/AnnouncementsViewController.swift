//
//  AnnouncementsViewController.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 10/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class AnnouncementsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let getAnnouncementsURL = "http://freejapp.com/FreejAppRequest/GetAnnouncements.php"
    let postAnnouncementURL = "http://freejapp.com/FreejAppRequest/PostAnnouncements.php"
    
    var announcements : [Announcement] = []
    
    var headerNumber = 1
    var header : Announcement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        announcements = createArray()
        header = announcements[headerNumber]
        announcements.remove(at: headerNumber)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func createArray() -> [Announcement] {
        var temp : [Announcement] = []
        
        temp.append(Announcement(type: "General", content: "This is an example of general announcement created by the admin KHALEEED"))
        temp.append(Announcement(type: "Specific", content: "This is an example of specific announcement created by the ameen KHALEEED"))
        temp.append(Announcement(type: "Technical", content: "This is an example of other announcement created by the admin KHALEEED"))
        temp.append(Announcement(type: "General", content: "This is an example of general announcement created by the admin KHALEEED"))
        temp.append(Announcement(type: "Specific", content: "This is an example of specific announcement created by the ameen KHALEEED"))
        temp.append(Announcement(type: "Technical", content: "This is an example of other announcement created by the admin KHALEEED"))
        temp.append(Announcement(type: "General", content: "This is an example of general announcement created by the admin KHALEEED"))
        temp.append(Announcement(type: "Specific", content: "This is an example of specific announcement created by the ameen KHALEEED"))
        temp.append(Announcement(type: "Technical", content: "This is an example of other announcement created by the admin KHALEEED"))
        
        return temp
    }
    
    func getAnnouncements(completion: @escaping (JSON?) -> ()) {
        Alamofire.request(getAnnouncementsURL, method: .post, parameters: nil, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
            let responseValue = response.result.value ?? nil
            responseValue == nil ? completion(nil) : completion(JSON(responseValue!)[0])
        }
    }
    
    func postAnnouncement(_ anTID: String, _ userID: String, _ title: String, _ descrp: String, completion: @escaping (Bool) -> ()) {
        let params =   ["AnTID" : anTID,
                        "UserID" : userID,
                        "Title" : title,
                        "Descrp" : descrp,
                        "SDate" : "2020",
                        "Stat" : "Activated"]
        
        Alamofire.request(postAnnouncementURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
            print(response)
            completion(response.result.isSuccess)
        }
    }
    
    


}
extension AnnouncementsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(indexPath.row)
        let announcement = announcements[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        165
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView {
        

        let header = tableView.dequeueReusableCell(withIdentifier: "AnnouncementCell") as! AnnouncementCell
        header.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        header.mainLabel.textColor = #colorLiteral(red: 0.8736796379, green: 0.1468148232, blue: 0.08675638586, alpha: 1)
        header.typeLabel.textColor = #colorLiteral(red: 0.8736796379, green: 0.1468148232, blue: 0.08675638586, alpha: 1)
        header.icon.tintColor = #colorLiteral(red: 0.8736796379, green: 0.1468148232, blue: 0.08675638586, alpha: 1)
        header.setAnnouncement(announcement: self.header)
        
        return header
    }
    
    
}

