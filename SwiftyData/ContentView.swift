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
    @State private var path = [Destination]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(destination) { destination in
                    NavigationLink(value: destination) {
                        VStack(alignment: .leading) {
                            Text(destination.name)
                                .font(.headline)
                            Text(destination.date.formatted(date: .long, time: .shortened))
                            Text(destination.details)
                                .font(.caption)
                        }
                    }
                }
                .onDelete(perform: deleteDestinations)
            }
            .navigationTitle("iTour")
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .toolbar {
                Button("Add Samples", systemImage: "bolt", action: addSamples)
                Button("Add Destination", systemImage: "plus", action: addDestination)
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
    
    func addDestination(){
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
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
