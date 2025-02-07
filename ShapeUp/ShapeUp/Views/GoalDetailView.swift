//
//  GoalDetailView.swift
//  ShapeUp
//
//  Created by Clay Morton on 2/7/25.
//

import SwiftUI

struct GoalDetailView: View {
    var goal: Goal
    @ObservedObject var viewModel: GoalViewModel
    
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
                    ForEach(checklist.indices, id: \.self) { index in
                        HStack {
                            Text(checklist[index].title)
                            Spacer()
                            Image(systemName: checklist[index].isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(checklist[index].isCompleted ? .green : .gray)
                                .onTapGesture {
                                    // Toggle checklist item completion
                                    goal.checklist?[index].isCompleted.toggle()
                                    goal.updateCompletionStatus()
                                    viewModel.saveGoals() // Save changes
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
