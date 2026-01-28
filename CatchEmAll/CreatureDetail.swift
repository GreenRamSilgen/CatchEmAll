//
//  CreatureDetail.swift
//  CatchEmAll
//
//  Created by Kiran Shrestha on 1/26/26.
//

import Foundation

@Observable
class CreatureDetail {
    private struct Returned: Codable{
        var height: Double
        var weight: Double
        var sprites: Sprite
    }
    
    private struct Sprite: Codable {
        var other : Other
    }
    
    struct Other : Codable {
        var  officialArtwork: OfficialArtwork
        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
    
    struct OfficialArtwork: Codable {
        var front_default : String
    }
    
    var urlString = ""
    var height = 0.0
    var weight = 0.0
    var imageUrl = ""
    
    func getData() async {
        guard let pokemonURL = URL(string: urlString) else { return }
        
        do {
            let (pokemonData, _) = try await URLSession.shared.data(from: pokemonURL)
            let returned = try JSONDecoder().decode(Returned.self, from: pokemonData)
            
            self.height = returned.height
            self.weight = returned.weight
            self.imageUrl = returned.sprites.other.officialArtwork.front_default ?? "n/a"
        }
        catch {
            print("Failed to call API. 😡Error:\n \(error)\n Error End😡")
        }
    }
}
