//
//  Creatures.swift
//  CatchEmAll
//
//  Created by Kiran Shrestha on 1/23/26.
//

import Foundation

@Observable
class Creatures {
    private struct Returned: Codable{
        var count : Int
        var next : String?
        var results : [Creature]
    }
    
    var urlString = "https://pokeapi.co/api/v2/pokemon/"
    var count = 0
    var creaturesArray : [Creature] = []
    var isLoading = false
    
    func getData() async {
        guard let pokemonURL = URL(string: urlString) else { return }
        isLoading = true
        do {
            let (pokemonData, _) = try await URLSession.shared.data(from: pokemonURL)
            let returned = try JSONDecoder().decode(Returned.self, from: pokemonData)
            isLoading = false
            
            Task { @MainActor in
                self.count = returned.count
                self.urlString = returned.next ?? ""
                self.creaturesArray = self.creaturesArray + returned.results
                isLoading = false
            }
        }
        catch {
            isLoading = false
            print("Failed to call API. 😡Error:\n \(error)\n Error End😡")
        }
    }
    
    func loadNextIfNeeded(creature: Creature) async {
        guard let lastCreature = creaturesArray.last else { return }
        if creature.id == lastCreature.id && urlString.hasPrefix("http") {
            await getData()
        }
    }
    func loadAll() async {
        
        Task { @MainActor in
            guard urlString.hasPrefix("http") else { return }
            
            await getData()
            await loadAll()
        }
    }
}
