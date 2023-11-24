//
//  DestinationListingView.swift
//  SwiftyData
//
//  Created by Mert Durkaya on 23.10.2023.
//

import SwiftData
import SwiftUI

struct DestinationListingView: View {
    @Environment (\.modelContext) var modelContext
    @Query(sort: [SortDescriptor (\Destination.priority, order: .reverse), SortDescriptor(\Destination.name)]) var destination: [Destination]
    
    var body: some View {
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
    }
    
    init(sort: SortDescriptor<Destination>, searchString: String) {
        _destination = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destination[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "")
}
