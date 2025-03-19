//
//  HeroModel.swift
//  SuperHeroApp2MVVM
//
//  Created by Alibek Baisholanov on 15.03.2025.
//

import Foundation

struct SuperHeroEntity: Decodable {
    var id: Int
    var name: String
    var appearance: Appearance?
    var biography: Biography
    var images: Images
    
    var imageUrl: URL? {
        URL(string: images.md)
    }
}

struct Appearance: Decodable {
    var gender: String?
    var race: String?
    var eyeColor: String?
    var hairColor: String?
}

struct Biography: Decodable {
    var fullName: String?
    var placeOfBirth: String?
    var publisher: String?
}

struct Images: Decodable {
    var md: String
}
