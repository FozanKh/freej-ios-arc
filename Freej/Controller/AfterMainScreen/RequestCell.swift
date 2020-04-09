//
//  RequestCell.swift
//  Freej
//
//  Created by khaled khamis on 09/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class RequestCell: UITableViewCell {

    
    
    var activities : [Actitvities] = []
        
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            activities = createArray()
            collection.delegate = self
            collection.dataSource = self
            
        }
        
        func createArray() -> [Actitvities] {
            var temp : [Actitvities] = []
            
            
            
            temp.append(Actitvities(type: "request", title: "printer", text: "This message came from Request", time: "today", status: "active"))
            temp.append(Actitvities(type: "request", title: "Ics201", text: "This message came from Request", time: "today", status: "active"))
            temp.append(Actitvities(type: "request", title: "Iphone X", text: "This message came from Request", time: "today", status: "active"))
            
            return temp
        }
        
        
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
