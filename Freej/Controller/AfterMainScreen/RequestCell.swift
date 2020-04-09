//
//  RequestCell.swift
//  Freej
//
//  Created by khaled khamis on 09/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class RequestCell: UITableViewCell {
    
    let getActivityURL = "http://freejapp.com/FreejAppRequest/GetActivity.php"
    var activities : [Actitvities] = []
        
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            getActivity()
            // Initialization code
//            activities = createArray()
            collection.delegate = self
            collection.dataSource = self
            
        }
    
        func getActivity() {
            Alamofire.request(getActivityURL, method: .post, parameters: ["AcTID" : 1], encoding: URLEncoding.default, headers: .none).validate().responseJSON { (response) in
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
        
//        func createArray() -> [Actitvities] {
//            var temp : [Actitvities] = []
//
//
//
//            temp.append(Actitvities(type: "request", title: "printer", text: "This message came from Request", time: "today", status: "active"))
//            temp.append(Actitvities(type: "request", title: "Ics201", text: "This message came from Request", time: "today", status: "active"))
//            temp.append(Actitvities(type: "request", title: "Iphone X", text: "This message came from Request", time: "today", status: "active"))
//
//            return temp
//        }
        
        
    }
    extension RequestCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            activities.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let actitviti = activities[indexPath.row]
            
            let content = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
            content.setActivity(activity: actitviti)
            self.typeLabel.text = "Request"
            content.iconIM.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            content.cellView.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            
            return content
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 324, height: 121)
        }
        
        
        
        
    }
