//
//  CreaturesListView.swift
//  CatchEmAll
//
//  Created by Kiran Shrestha on 1/23/26.
//

import SwiftUI

struct CreaturesListView: View {
    @State var creatures = Creatures()
    
    var body: some View {
        NavigationStack {
            List(creatures.creaturesArray, id: \.self) { creature in
                NavigationLink {
                    DetailView(creature: creature)
                } label: {
                    Text(creature.name.capitalized)
                        .font(.title2)
                }

            }
            .listStyle(.plain)
            .navigationTitle("Pokemon")
        }
        .task {
            await creatures.getData()
        }
    }
    
}

#Preview {
    CreaturesListView()
}
