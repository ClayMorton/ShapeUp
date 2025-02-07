//
//  GoalDetailView.swift
//  ShapeUp
//
//  Created by Clay Morton on 2/7/25.
//

import SwiftUI

struct GoalDetailView: View {
    var goal: Goal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: goal.icon)
                Text(goal.name)
                    .font(.largeTitle)
            }
            
            if let description = goal.description {
                Text(description)
                    .font(.body)
            }
            
            if let checklist = goal.checklist {
                List {
                    ForEach(checklist) { item in
                        HStack {
                            Text(item.title)
                            Spacer()
                            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                .onTapGesture {
                                    // Toggle completion
                                }
                        }
                    }
                }
            }
            
            if let workoutGoal = goal as? WorkoutGoal {
                VStack(alignment: .leading) {
                    Text("Reps: \(workoutGoal.reps ?? 0)")
                    Text("Weight: \(workoutGoal.weight ?? 0, specifier: "%.2f") lbs")
                }
            }
            
            Spacer()
        }
        .padding()
    }
}
