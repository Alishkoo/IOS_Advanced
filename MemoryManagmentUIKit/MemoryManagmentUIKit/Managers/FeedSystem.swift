//
//  FeedSystem.swift
//  MemoryManagmentUIKit
//
//  Created by Alibek Baisholanov on 20.02.2025.
//

import Foundation

class FeedSystem {
    
    private var userCache: [UUID: UserProfile] = [:]

    
    private var feedPosts: [Post] = []

   
    private var hashtags: Set<String> = []

    
    func addPost(_ post: Post) {
        feedPosts.insert(post, at: 0)
    }

   
    func removePost(_ post: Post) {
        if let index = feedPosts.firstIndex(where: { $0.id == post.id }) {
            feedPosts.remove(at: index)
        }
    }

    
    func addUserToCache(_ user: UserProfile) {
        userCache[user.id] = user
    }

    
    func getUserFromCache(by id: UUID) -> UserProfile? {
        return userCache[id]
    }

   
    func addHashtag(_ hashtag: String) {
        hashtags.insert(hashtag)
    }

   
    func hasHashtag(_ hashtag: String) -> Bool {
        return hashtags.contains(hashtag)
    }
}

