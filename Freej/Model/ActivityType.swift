//
//  ActivityType.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 16/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ActivityType {
	let acTID:		Int
	let typeName:	String
	let color1Hex:	String
	let color2Hex:	String
	
	static func getActivityTypesArray(fromJSON: JSON) -> [ActivityType]? {
		return nil
	}
}
