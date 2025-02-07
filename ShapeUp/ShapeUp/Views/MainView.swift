//
//  MainView.swift
//  ShapeUp
//
//  Created by Clay Morton on 2/7/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = GoalViewModel()
    @State private var showingAddGoalView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.goals) { goal in
                    NavigationLink(destination: GoalDetailView(goal: goal, viewModel: viewModel)) {
                        HStack {
                            Image(systemName: goal.icon)
                            Text(goal.name)
                            Spacer()
                            Image(systemName: goal.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(goal.isCompleted ? .green : .gray)
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteGoal)
            }
            .navigationTitle("ShapeUp")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddGoalView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddGoalView) {
                AddGoalView(viewModel: viewModel)
            }
        }
    }
}
