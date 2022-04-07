//
//  Plan.swift
//  Planner
//
//  Created by Darma Wiryanata on 06/04/22.
//

import Foundation

struct Plan: Identifiable, Codable {
    let id: String
    let title: String
    let date: Date?
    let time: Date?
    let note: String?
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, date: Date? = nil, time: Date? = nil, note: String? = nil, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.date = date
        self.time = time
        self.note = note
        self.isCompleted = isCompleted
    }
}
