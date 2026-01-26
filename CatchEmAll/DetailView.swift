//
//  DetailView.swift
//  CatchEmAll
//
//  Created by Kiran Shrestha on 1/26/26.
//

import SwiftUI

struct DetailView: View {
    let creature: Creature
    @State private var creatureDetail = CreatureDetail()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(creature.name.capitalized)
                .font(Font.custom("Avenir Next Condensed", size: 60))
                .bold()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray)
                .padding(.bottom)
            
            HStack {
                AsyncImage(url: URL(string: creatureDetail.imageUrl)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 8, x: 5, y: 5)
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 16).stroke(.gray.opacity(0.5), lineWidth: 1)
                            })
                            .padding(.trailing)
                    } else if phase.error != nil {
                    }
                    else {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .scaleEffect(2)
                    }
                }
                .frame(width: 100, height: 100)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text("Height:")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.red)
                        Text(String(format: "%.2f", creatureDetail.height))
                            .font(.largeTitle)
                            .bold()
                    }
                    HStack(alignment: .top) {
                        Text("Weight:")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.red)
                        Text(String(format: "%.2f", creatureDetail.weight))
                            .font(.largeTitle)
                            .bold()
                    }
                }
                
            }
            Spacer()
        }
        .padding()
        .task {
            creatureDetail.urlString = creature.url
            await creatureDetail.getData()
        }
    }
}

#Preview {
    DetailView(creature: Creature(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"))
}
