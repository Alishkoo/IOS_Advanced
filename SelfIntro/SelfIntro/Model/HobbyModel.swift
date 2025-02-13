//
//  HobbyModel.swift
//  SelfIntro
//
//  Created by Alibek Baisholanov on 12.02.2025.
//

import Foundation

struct Hobby: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let description: String
}
