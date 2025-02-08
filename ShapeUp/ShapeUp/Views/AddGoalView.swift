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
                        Image(systemName: "figure.walk").tag("figure.walk")
                        Image(systemName: "dumbbell").tag("dumbbell")
                        Image(systemName: "figure.core.training").tag("figure.core.training")
                    }
                    .scaledToFit()
                }
                
                Section {
                    Button("Save") {
                        let goal = Goal(name: name, description: description, icon: icon)
                        viewModel.addGoal(goal)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Add Goal")
        }
    }
}
