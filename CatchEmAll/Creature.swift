//
//  Creature.swift
//  CatchEmAll
//
//  Created by Kiran Shrestha on 1/26/26.
//

import Foundation

struct Creature : Codable, Identifiable {
    let id = UUID().uuidString
    
    var name : String
    var url : String
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }
}
