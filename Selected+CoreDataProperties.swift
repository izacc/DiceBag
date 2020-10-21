//
//  Selected+CoreDataProperties.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 10/21/20.
//
//

import Foundation
import CoreData


extension Selected {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Selected> {
        return NSFetchRequest<Selected>(entityName: "Selected")
    }

    @NSManaged public var selected: Bool
    @NSManaged public var group: Group?

}

extension Selected : Identifiable {

}
