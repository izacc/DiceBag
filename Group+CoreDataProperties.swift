//
//  Group+CoreDataProperties.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 10/21/20.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var group_name: String
    @NSManaged public var desc: String
    @NSManaged public var player: NSSet

}

// MARK: Generated accessors for player
extension Group {

    @objc(addPlayerObject:)
    @NSManaged public func addToPlayer(_ value: Player)

    @objc(removePlayerObject:)
    @NSManaged public func removeFromPlayer(_ value: Player)

    @objc(addPlayer:)
    @NSManaged public func addToPlayer(_ values: NSSet)

    @objc(removePlayer:)
    @NSManaged public func removeFromPlayer(_ values: NSSet)

}

extension Group : Identifiable {

}
