//
//  HeroModel.swift
//  SuperHeroApp2MVVM
//
//  Created by Alibek Baisholanov on 18.03.2025.
//

import Foundation

struct HeroModel: Identifiable {
    var id: Int
    var title: String
    var description: String
    var apperance: String
    var publisher: String
    var imageUrl: URL?
}
