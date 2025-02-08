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
            ZStack {
                if viewModel.goals.isEmpty {
                    TutorialCardView()
                } else {
                    // Swipeable goal cards
                    ScrollView(.horizontal, showsIndicators: false) {
                        ForEach(viewModel.goals) { goal in
                            GoalCardView(goal: goal, viewModel: viewModel)
                                .padding(.horizontal, 20)
                        }
                    }
                    .scrollTargetBehavior(.paging)
                }
            }
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
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.green.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
            )
            .scaledToFill()
        }
    }
}
