//
//  Student+CoreDataProperties.swift
//  
//
//  Created by khaled khamis on 29/03/2020.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var bno: String?
    @NSManaged public var fName: String?
    @NSManaged public var gender: String?
    @NSManaged public var kfupmID: String?
    @NSManaged public var lName: String?
    @NSManaged public var stat: String?
    @NSManaged public var userID: String?

}
