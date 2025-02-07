//
//  AddGoalView.swift
//  ShapeUp
//
//  Created by Clay Morton on 2/7/25.
//

import SwiftUI

struct AddGoalView: View {
    @ObservedObject var viewModel: GoalViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var description = ""
    @State private var icon = "star"
    @State private var isWorkoutGoal = false
    @State private var reps = ""
    @State private var weight = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Goal Details")) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    Picker("Icon", selection: $icon) {
                        Image(systemName: "star").tag("star")
                        Image(systemName: "heart").tag("heart")
                        Image(systemName: "flame").tag("flame")
                    }
                }
                
                Section(header: Text("Type")) {
                    Toggle("Is Workout Goal", isOn: $isWorkoutGoal)
                    
                    if isWorkoutGoal {
                        TextField("Reps", text: $reps)
                            .keyboardType(.numberPad)
                        TextField("Weight", text: $weight)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section {
                    Button("Save") {
                        if isWorkoutGoal {
                            let workoutGoal = WorkoutGoal(name: name, description: description, icon: icon, reps: Int(reps), weight: Double(weight))
                            viewModel.addGoal(workoutGoal)
                        } else {
                            let goal = Goal(name: name, description: description, icon: icon)
                            viewModel.addGoal(goal)
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Add Goal")
        }
    }
}
