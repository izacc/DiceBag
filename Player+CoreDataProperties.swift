//
//  Player+CoreDataProperties.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 10/21/20.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var name: String?
    @NSManaged public var group: Group?

}

extension Player : Identifiable {

}
