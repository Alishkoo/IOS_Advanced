//
//  UserProfile.swift
//  MemoryManagmentUIKit
//
//  Created by Alibek Baisholanov on 20.02.2025.
//

import Foundation

struct UserProfile: Hashable, Equatable {
    let id: UUID
    let username: String
    var bio: String
    var followers: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: UserProfile, rhs: UserProfile) -> Bool {
        return lhs.id == rhs.id
    }
}
