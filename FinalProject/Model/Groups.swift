//
//  Groups.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 10/20/20.
//

import Foundation

struct Groups: Codable{
    var results:[Groups]
}

struct TheGroup{

    var desc: String
    var group_name: String
    var players: NSSet
    var selected: Bool
}
