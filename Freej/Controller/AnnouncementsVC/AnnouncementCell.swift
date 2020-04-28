//
//  AnnouncementCell.swift
//  Freej
//
//  Created by khaled khamis on 29/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class AnnouncementCell: UITableViewCell {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    func setAnnouncement(announcement : Announcement){
		mainLabel.text = announcement.descrp
		typeLabel.text = "\(announcement.anTID)"
    }
}
