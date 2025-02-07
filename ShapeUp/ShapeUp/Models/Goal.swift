//
//  Goal.swift
//  ShapeUp
//
//  Created by Clay Morton on 2/7/25.
//

import Foundation

import Foundation

class Goal: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String?
    var icon: String
    var checklist: [ChecklistItem]?
    var isCompleted: Bool = false // Track completion status
    
    init(name: String, description: String? = nil, icon: String, checklist: [ChecklistItem]? = nil, isCompleted: Bool = false) {
        self.name = name
        self.description = description
        self.icon = icon
        self.checklist = checklist
        self.isCompleted = isCompleted
    }
    
    // Helper function to check if all checklist items are completed
    func updateCompletionStatus() {
        if let checklist = checklist, !checklist.isEmpty {
            isCompleted = checklist.allSatisfy { $0.isCompleted }
        }
    }
}
