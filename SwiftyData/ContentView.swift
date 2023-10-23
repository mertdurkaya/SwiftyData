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
    @State private var path = [Destination]()
    @State private var sortOrder = SortDescriptor(\Destination.name)
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder)
            .navigationTitle("iTour")
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .toolbar {
                Button("Add Samples", systemImage: "bolt", action: addSamples)
                Button("Add Destination", systemImage: "plus", action: addDestination)
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name")
                            .tag(SortDescriptor(\Destination.name))
                        Text("Priorty")
                            .tag(SortDescriptor(\Destination.priority, order: .reverse))
                        Text("Date")
                            .tag(SortDescriptor(\Destination.date))
                    }
                    .pickerStyle(.inline)
                }
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
    

}

#Preview {
    ContentView()
}
