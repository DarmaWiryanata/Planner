//
//  Plan.swift
//  Planner
//
//  Created by Darma Wiryanata on 06/04/22.
//

import Foundation

struct Plan: Identifiable, Codable {
    var id: String
    var title: String
    var date: Date?
    var note: String?
    var isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, date: Date? = nil, note: String? = nil, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.date = date
        self.note = note
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> Plan {
        return Plan(id: id, title: title, isCompleted: !isCompleted)
    }
}
