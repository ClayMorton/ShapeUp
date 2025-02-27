//
//  TutorialCard.swift
//  ShapeUp
//
//  Created by Clay Morton on 2/7/25.
//

import SwiftUI

struct TutorialCardView: View {
    var body: some View {
        //        ZStack {
        //            // Rounded rectangle as the card background
        //            RoundedRectangle(cornerRadius: 20)
        //                .fill(
        //                    LinearGradient(
        //                        gradient: Gradient(colors: [Color.gray.opacity(0.0), Color.gray.opacity(0.0)]),
        //                        startPoint: .top,
        //                        endPoint: .bottom
        //                    )
        //                )
        
        // Content on top of the card
        VStack(spacing: 20) {
            Text("Welcome to ShapeUp!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            Text("To get started, tap the '+' button to create your first goal.")
                .font(.subheadline)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
