//
//  PostGripView.swift
//  SelfIntro
//
//  Created by Alibek Baisholanov on 06.02.2025.
//

import Foundation
class PostGrip: ObservableObject {
    var selected: PostModel?{
        didSet{
            didSetPost = true
        }
    }
    @Published var didSetPost = false
}
