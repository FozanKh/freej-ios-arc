//
//  Announcement.swift
//  Freej
//
//  Created by khaled khamis on 29/03/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import UIKit

class Announcement {
    var icon : UIImage
    var type : String
    var content : String
    
    init(type : String, content : String) {
        self.type = type
        switch type {
        case "General":
            self.icon = UIImage(systemName: "mic.fill")!
        case "Specific":
            self.icon = UIImage(systemName: "bubble.left.fill")!
        default:
            self.icon = UIImage(systemName: "person.fill")!
        }
        
        self.content = content
    
    }
    
}
