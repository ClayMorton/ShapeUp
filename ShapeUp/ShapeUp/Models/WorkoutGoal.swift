//
//  WorkoutGoal.swift
//  ShapeUp
//
//  Created by Clay Morton on 2/7/25.
//

import Foundation

class WorkoutGoal: Goal {
    var reps: Int?
    var weight: Double?
    
    init(name: String, description: String? = nil, icon: String, checklist: [ChecklistItem]? = nil, reps: Int? = nil, weight: Double? = nil) {
        self.reps = reps
        self.weight = weight
        super.init(name: name, description: description, icon: icon, checklist: checklist)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        reps = try container.decodeIfPresent(Int.self, forKey: .reps)
        weight = try container.decodeIfPresent(Double.self, forKey: .weight)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(reps, forKey: .reps)
        try container.encodeIfPresent(weight, forKey: .weight)
        try super.encode(to: encoder)
    }
    
    enum CodingKeys: String, CodingKey {
        case reps, weight
    }
}
