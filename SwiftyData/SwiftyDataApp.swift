//
//  SwiftyDataApp.swift
//  SwiftyData
//
//  Created by Mert Durkaya on 23.10.2023.
//

import SwiftData
import SwiftUI

@main
struct SwiftyDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
