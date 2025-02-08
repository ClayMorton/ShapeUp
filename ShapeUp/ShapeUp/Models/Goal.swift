//
//  Goal.swift
//  ShapeUp
//
//  Created by Clay Morton on 2/7/25.
//

import Foundation
import SwiftUI

class Goal: Identifiable, ObservableObject, Codable {
    var id = UUID()
    var name: String
    var description: String?
    var icon: String
    @Published var checklist: [ChecklistItem]?
    @Published var isCompleted: Bool = false
    
    init(name: String, description: String? = nil, icon: String, checklist: [ChecklistItem]? = nil, isCompleted: Bool = false) {
        self.name = name
        self.description = description
        self.icon = icon
        self.checklist = checklist
        self.isCompleted = isCompleted
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, icon, checklist, isCompleted
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        icon = try container.decode(String.self, forKey: .icon)
        checklist = try container.decodeIfPresent([ChecklistItem].self, forKey: .checklist)
        isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encode(icon, forKey: .icon)
        try container.encodeIfPresent(checklist, forKey: .checklist)
        try container.encode(isCompleted, forKey: .isCompleted)
    }
    
    // Helper function to check if all checklist items are completed
    func updateCompletionStatus() {
        if let checklist = checklist, !checklist.isEmpty {
            isCompleted = checklist.allSatisfy { $0.isCompleted }
        }
    }
}
