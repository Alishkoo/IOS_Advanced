//
//  ContentView.swift
//  SelfIntro
//
//  Created by Alibek Baisholanov on 03.02.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem{
                    Label("Home", systemImage: "house")
            }
            HobbiesView()
                .tabItem{
                    Label("Hobbies", systemImage: "sparkles")
                }
            GoalsView()
                .tabItem{
                    Label("Goals", systemImage: "flag.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
