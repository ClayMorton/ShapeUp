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
    
    // Add a new goal
    func addGoal(_ goal: Goal) {
        goals.append(goal)
        saveGoals()
    }
    
    // Delete a specific goal
    func deleteGoal(_ goal: Goal) {
        if let index = goals.firstIndex(where: { $0.id == goal.id }) {
            goals.remove(at: index)
            saveGoals()
        }
    }
    
    // Save goals to UserDefaults
    func saveGoals() { // Removed `private` access level
        if let encoded = try? JSONEncoder().encode(goals) {
            UserDefaults.standard.set(encoded, forKey: "goals")
        }
    }
    
    // Load goals from UserDefaults
    private func loadGoals() {
        if let data = UserDefaults.standard.data(forKey: "goals") {
            if let decoded = try? JSONDecoder().decode([Goal].self, from: data) {
                goals = decoded
            }
        }
    }
}
