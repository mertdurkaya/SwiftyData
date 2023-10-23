//
//  ContentView.swift
//  SwiftyData
//
//  Created by Mert Durkaya on 23.10.2023.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment (\.modelContext) var modelContext
    @Query var destination: [Destination]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(destination) { destination in
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        Text(destination.date.formatted(date: .long, time: .shortened))
                        Text(destination.details)
                            .font(.caption)
                    }
                }
                .onDelete(perform: deleteDestinations)
            }
            .navigationTitle("iTour")
            .toolbar {
                Button("Add Samples", action: addSamples)
            }
        }
    }
    
    func addSamples() {
        let rome = Destination(name: "Rome", details: "Test details")
        let florence = Destination(name: "Florence", priority: 1)
        let naples = Destination(name: "Naples")
        
        modelContext.insert(rome)
        modelContext.insert(florence)
        modelContext.insert(naples)
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destination[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    ContentView()
}
