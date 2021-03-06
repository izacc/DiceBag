//
//  Selected+CoreDataProperties.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 12/4/20.
//
//

import Foundation
import CoreData


extension Selected {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Selected> {
        return NSFetchRequest<Selected>(entityName: "Selected")
    }

    @NSManaged public var currently_selected: Bool
    @NSManaged public var group: Group

}

extension Selected : Identifiable {

}
