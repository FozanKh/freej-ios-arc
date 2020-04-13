//
//  Activities.swift
//
//  Created by khaled khamis on 09/04/2020.
//  Copyright © 2020 khaled khamis. All rights reserved.
//

import Foundation
import UIKit

class Actitvities {
    
    var icon : UIImage
    var time : String
    var title : String
    var content : String
    var status : String
    var type : String
    
    init(type : String , title : String , text : String , time : String , status : String ) {
        self.title = title
        self.content = text
        self.time = time
        self.status = status
        self.type = type
        
        switch type {
        case "request":
            self.icon = UIImage(systemName: "mic.fill")!
        case "maintenance":
            self.icon = UIImage(systemName: "bubble.left.fill")!
        default:
            self.icon = UIImage(systemName: "person.fill")!
        }
        
    }
    
}
