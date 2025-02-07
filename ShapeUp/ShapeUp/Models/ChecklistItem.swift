//
//  ChecklistItem.swift
//  ShapeUp
//
//  Created by Clay Morton on 2/7/25.
//

import Foundation

struct ChecklistItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
}
