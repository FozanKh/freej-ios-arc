//
//  MaintenanceCell.swift
//  Freej
//
//  Created by khaled khamis on 09/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class MaintenanceCell: UITableViewCell {

    
    @IBOutlet weak var typeLab: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    
    var activities : [Actitvities] = []
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            activities = createArray()
            collection.delegate = self
            collection.dataSource = self
            
        }
        
        func createArray() -> [Actitvities] {
            var temp : [Actitvities] = []
            
            
            
            temp.append(Actitvities(type: "maintenance", title: "Bathroom 214", text: "This message came from maintenance", time: "today", status: "active"))
            temp.append(Actitvities(type: "maintenance", title: "Bathroom 314", text: "This message came from maintenance", time: "today", status: "active"))
            temp.append(Actitvities(type: "maintenance", title: "Bathroom 114", text: "This message came from maintenance", time: "today", status: "active"))
            
            return temp
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

