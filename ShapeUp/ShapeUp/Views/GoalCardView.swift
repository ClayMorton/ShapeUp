//
//  GoalCardView.swift
//  ShapeUp
//
//  Created by Clay Morton on 2/7/25.
//

import SwiftUI

struct GoalCardView: View {
    @ObservedObject var goal: Goal
    @ObservedObject var viewModel: GoalViewModel
    
    @State private var offset: CGSize = .zero
    @State private var isEditing: Bool = false // Toggle between view and edit modes
    @State private var editedTitle: String = ""
    @State private var editedDescription: String = ""
    @State private var editedChecklist: [ChecklistItem] = []
    
    var body: some View {
        ZStack {
            // Rounded rectangle as the card background
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.8)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .shadow(radius: 10)
            
            // Content on top of the card
            VStack(alignment: .leading, spacing: 10) {
                // Goal name and icon with edit button
                HStack {
                    Image(systemName: goal.icon)
                        .foregroundColor(.white)
                    
                    if isEditing {
                        TextField("Title", text: $editedTitle)
                            .font(.headline)
                            .foregroundColor(.white)
                    } else {
                        Text(goal.name)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if isEditing {
                            // Save changes when exiting edit mode
                            goal.name = editedTitle
                            goal.description = editedDescription
                            goal.checklist = editedChecklist
                            viewModel.saveGoals()
                        }
                        isEditing.toggle()
                    }) {
                        Image(systemName: isEditing ? "checkmark.circle.fill" : "pencil.circle.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                }
                
                // Goal description
                if isEditing {
                    TextField("Description", text: $editedDescription)
                        .font(.subheadline)
                        .foregroundColor(.white)
                } else if let description = goal.description, !description.isEmpty {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .lineLimit(2)
                }
                
                // Checklist items
                if let checklist = goal.checklist {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(checklist.indices, id: \.self) { index in
                            HStack {
                                if isEditing {
                                    TextField("Checklist Item", text: Binding(
                                        get: { checklist[index].title },
                                        set: { editedChecklist[index].title = $0 }
                                    ))
                                    .foregroundColor(.white)
                                } else {
                                    Text(checklist[index].title)
                                }
                                
                                Spacer()
                                
                                if !isEditing {
                                    Image(systemName: checklist[index].isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(checklist[index].isCompleted ? .green : .gray)
                                        .onTapGesture {
                                            // Toggle checklist item completion
                                            goal.checklist?[index].isCompleted.toggle()
                                            goal.updateCompletionStatus()
                                            viewModel.saveGoals()
                                        }
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                
                // Completion status icon
                if !isEditing {
                    Image(systemName: goal.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(goal.isCompleted ? .green : .gray)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding()
        }
        .padding()
        .offset(y: offset.height)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset.height = gesture.translation.height
                }
                .onEnded { gesture in
                    if abs(offset.height) > 100 {
                        // Delete the goal
                        viewModel.deleteGoal(goal)
                    } else {
                        offset = .zero
                    }
                }
        )
        .animation(.spring(), value: offset)
        .onAppear {
            // Initialize editable fields when the view appears
            editedTitle = goal.name
            editedDescription = goal.description ?? ""
            editedChecklist = goal.checklist ?? []
        }
    }
}
