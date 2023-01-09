//
//  DessertAppApp.swift
//  DessertApp
//
//  Created by Meder iZimov on 1/8/23.
//

import SwiftUI

@main
//  DessertApp
struct DessertAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(dessertListVM: DessertListViewModel())
        }
    }
}
