
import Foundation

struct SuperHero: Decodable {
    var id: Int?
    var name: String?
    var appearance: Appearance?
    var biography: Biography?
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
