//
//  History+CoreDataProperties.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 12/4/20.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var playerName: String
    @NSManaged public var rollHistory: String
    @NSManaged public var group: Group

}

extension History : Identifiable {

}
