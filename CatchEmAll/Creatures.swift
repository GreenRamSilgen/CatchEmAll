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
        var next : String
        var results : [Result]
    }
    
    struct Result : Codable, Hashable {
        var name : String
        var url : String
    }
    
    var urlString = "https://pokeapi.co/api/v2/pokemon/"
    var count = 0
    var creaturesArray : [Result] = []
    
    
    func getData() async {
        guard let pokemonURL = URL(string: urlString) else { return }
        
        do {
            let (pokemonData, _) = try await URLSession.shared.data(from: pokemonURL)
            
            let returned = try JSONDecoder().decode(Returned.self, from: pokemonData)
            self.count = returned.count
            self.urlString = returned.next
            self.creaturesArray = returned.results
            
        }
        catch {
            print("Failed to call API. 😡Error:\n \(error)\n Error End😡")
        }
    }
}
