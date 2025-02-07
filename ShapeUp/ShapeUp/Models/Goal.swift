//
//  Goal.swift
//  ShapeUp
//
//  Created by Clay Morton on 2/7/25.
//

import Foundation

class Goal: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String?
    var icon: String
    var checklist: [ChecklistItem]?
    
    init(name: String, description: String? = nil, icon: String, checklist: [ChecklistItem]? = nil) {
        self.name = name
        self.description = description
        self.icon = icon
        self.checklist = checklist
    }
}
