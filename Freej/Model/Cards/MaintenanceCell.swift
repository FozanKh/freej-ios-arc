//
//  MaintenanceCell.swift
//  Freej
//
//  Created by khaled khamis on 09/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MaintenanceCell: UITableViewCell {

    let getActivityURL = "http://freejapp.com/FreejAppRequest/GetActivity.php"
    
    @IBOutlet weak var typeLab: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    
    var activities : [Actitvities] = []
        
        override func awakeFromNib() {
            super.awakeFromNib()
            getActivity()
            // Initialization code
//            activities = createArray()
            collection.delegate = self
            collection.dataSource = self
            
        }
        
//        func createArray() -> [Actitvities] {
//            var temp : [Actitvities] = []
//
//
//
//            temp.append(Actitvities(type: "maintenance", title: "Bathroom 214", text: "This message came from maintenance", time: "today", status: "active"))
//            temp.append(Actitvities(type: "maintenance", title: "Bathroom 314", text: "This message came from maintenance", time: "today", status: "active"))
//            temp.append(Actitvities(type: "maintenance", title: "Bathroom 114", text: "This message came from maintenance", time: "today", status: "active"))
//
//            return temp
//        }
        
    func getActivity() {
        Alamofire.request(getActivityURL, method: .post, parameters: ["AcTID" : 4], encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
            if let value = response.result.value {
                
                let json = JSON(value)
                self.activities.removeAll()
                for anItem in json.array! {
                    self.activities.append(Actitvities(type: anItem["AcTID"].stringValue, title: anItem["Title"].stringValue, text: anItem["Descrp"].stringValue, time: anItem["SDate"].stringValue, status: anItem["Stat"].stringValue))
                }
                print("======================",self.activities.count)
                
            }
            
            self.collection.reloadData()
        }
    }
        
    }
    extension MaintenanceCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            activities.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let actitviti = activities[indexPath.row]
            
            let content = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
            content.setActivity(activity: actitviti)
            content.cellView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            content.iconIM.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.typeLab.text = "Maintenance"
            return content
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 324, height: 121)
        }
        
        
        
        
    }

