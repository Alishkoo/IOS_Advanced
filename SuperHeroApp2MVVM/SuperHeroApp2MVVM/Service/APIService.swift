//
//  Untitled.swift
//  SuperHeroApp2MVVM
//
//  Created by Alibek Baisholanov on 15.03.2025.
//

import Foundation

final class APIService {
    static let shared = APIService()
    
    private init(){}
    
    private let baseURL = "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/"
    
    func fetchAllData() async -> Result<[SuperHeroEntity], Error> {
        guard let url = URL(string: (baseURL + "all.json")) else {
            return .failure(URLError(.badURL))
        }
        
        let urlRequest = URLRequest(url: url)
        
        do{
            let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
            let heroes = try JSONDecoder().decode([SuperHeroEntity].self, from: data)
            return .success(heroes)
            
        }catch{
            return .failure(error)
        }
    }
    
    
    func fetchById(id: Int) async -> Result<SuperHeroEntity, Error> {
        guard let url = URL(string: baseURL + "id/\(id).json") else {
            return .failure(URLError(.badURL))
        }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
            let hero = try JSONDecoder().decode(SuperHeroEntity.self, from: data)
            return .success(hero)
            
        } catch {
            return .failure(error)
        }
    }
}
