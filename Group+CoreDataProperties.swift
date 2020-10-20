//
//  Group+CoreDataProperties.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 10/20/20.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var group_name: String?
    @NSManaged public var desc: String?
    @NSManaged public var players: [String]?

}

extension Group : Identifiable {

}
