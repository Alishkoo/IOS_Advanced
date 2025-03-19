//
//  ViewModel.swift
//  SuperHeroApp
//
//  Created by Alibek Baisholanov on 04.03.2025.
//


import Foundation
import SwiftUI

final class SuperHeroViewModel : ObservableObject {
    @Published var hero: SuperHero?
    @Published var name: String = ""
    @Published var favouriteHeroes: [SuperHero] = []
    var heroesArray: [SuperHero] = []
    
    
    let mainUrl = "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json"
    
    func fetchHero() async {
        guard let url = URL(string: mainUrl) else { return }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, responce) = try await URLSession.shared.data(for: urlRequest)
            let heroes = try JSONDecoder().decode([SuperHero].self, from: data)
            heroesArray = heroes
            await MainActor.run {
                hero = heroes.randomElement()
            }
            
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func searchByName() async {
        var filteredHeroes = heroesArray.filter{ hero in
            guard let heroName = hero.name?.lowercased() else {return false}
            
            return heroName.contains(name.lowercased())
        }
        
        await MainActor.run {
            hero = filteredHeroes.randomElement()
        }
    }
    
    func addToFavourites() {
        guard let hero = hero else {return}
        favouriteHeroes.append(hero)
    }
    
}
