//
//  GoalViewModel.swift
//  ShapeUp
//
//  Created by Clay Morton on 2/7/25.
//

import Foundation

class GoalViewModel: ObservableObject {
    @Published var goals: [Goal] = []
    
    init() {
        loadGoals()
    }
    
    func addGoal(_ goal: Goal) {
        goals.append(goal)
        saveGoals()
    }
    
    func deleteGoal(at offsets: IndexSet) {
        goals.remove(atOffsets: offsets)
        saveGoals()
    }
    
    private func saveGoals() {
        if let encoded = try? JSONEncoder().encode(goals) {
            UserDefaults.standard.set(encoded, forKey: "goals")
        }
    }
    
    private func loadGoals() {
        if let data = UserDefaults.standard.data(forKey: "goals") {
            if let decoded = try? JSONDecoder().decode([Goal].self, from: data) {
                goals = decoded
            }
        }
    }
}
