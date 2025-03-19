//
//  DetailViewModel.swift
//  SuperHeroApp2MVVM
//
//  Created by Alibek Baisholanov on 19.03.2025.
//

import Foundation
import SwiftUI


final class DetailViewModel: ObservableObject {
    @Published var singleHero: HeroModel? = nil
    
    
    func loadHero(heroId: Int) async {
//        guard let heroId = Int(id ?? ""), heroId > 0 else {
//            return
//        }
        
        let result = await APIService.shared.fetchById(id: heroId)
        switch result {
        case .success(let hero):
            await MainActor.run{
                self.singleHero = HeroModel(
                    id: hero.id,
                    title: hero.name,
                    description: hero.biography.placeOfBirth ?? "None discription",
                    apperance: hero.appearance?.hairColor ?? "Black",
                    publisher: hero.biography.publisher ?? "No publisher",
                    imageUrl: hero.imageUrl
                )
            }
        case .failure(let error):
            print("\(error.localizedDescription)")
        }
    }
}
