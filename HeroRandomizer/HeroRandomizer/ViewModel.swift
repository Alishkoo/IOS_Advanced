import Foundation

struct Hero: Decodable {
    let images: Image
    var imageUrl: URL? {
        URL(string: images.md)
    }

    struct Image: Decodable {
        let md: String
    }
}

final class ViewModel: ObservableObject {
    @Published var selectedHero: Hero?

    // MARK: - Methods
    func fetchHero() async {
        guard
            let url = URL(string: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json")
        else {
            return
        }

        let urlRequest = URLRequest(url: url)

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let heroes = try JSONDecoder().decode([Hero].self, from: data)
            let randomHero = heroes.randomElement()

            await MainActor.run {
                selectedHero = randomHero
            }
        }
        catch {
            print("Error: \(error)")
        }
    }
}
