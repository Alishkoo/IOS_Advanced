//
//  GoalsView.swift
//  SelfIntro
//
//  Created by Alibek Baisholanov on 12.02.2025.
//

import SwiftUI 

struct GoalsView: View {
    let goals: [Goal] = [
        Goal(title: "Complete SwiftUI course", description: "Finish learning the basics of SwiftUI to build my first app.", dueDate: "15/03/2025"),
        Goal(title: "Start a new game project", description: "Begin development of a new 2D game with a unique concept.", dueDate: "01/06/2025")
    ]
    
    var body: some View {
        NavigationView {
            List(goals) { goal in
                VStack(alignment: .leading) {
                    Text(goal.title)
                        .font(.headline)
                        .padding(.bottom, 2)
                    
                    Text(goal.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 4)
                    
                    Text("Due by: \(goal.dueDate)")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                .padding()
            }
            .navigationTitle("Goalsпи")
        }
    }
}

struct Goal: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let dueDate: String
}

#Preview {
    GoalsView()
}
