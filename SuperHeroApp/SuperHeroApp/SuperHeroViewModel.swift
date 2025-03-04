//
//  ViewModel.swift
//  SuperHeroApp
//
//  Created by Alibek Baisholanov on 04.03.2025.
//

import Foundation

final class SuperHeroViewModel : ObservableObject {
    @Published var hero: SuperHero
    let mainUrl = "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json"
    
    func fetchHero() async {
        guard let url = URL(string: mainUrl) else { return }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, responce) = try await URLSession.shared.data(for: urlRequest)
            let heroes = try JSONDecoder().decode([SuperHero].self, from: data)
            
            await MainActor.run {
//                selectedHero = randomHero
            }
            
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
}
