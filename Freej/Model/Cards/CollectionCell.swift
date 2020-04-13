//
//  CollectionCell.swift
//  Freej
//
//  Created by khaled khamis on 09/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var iconIM: UIImageView!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var contentLB: UILabel!
    @IBOutlet weak var statusLB: UILabel!
    
    func setActivity(activity : Actitvities){
           contentLB.text = activity.content
           statusLB.text = activity.status
           iconIM.image = activity.icon
           timeLB.text = activity.time
           titleLB.text = activity.title
       }
}
