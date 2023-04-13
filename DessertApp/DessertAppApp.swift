//
//  DessertAppApp.swift
//  DessertApp
//
//  Created by Meder iZimov on 4/12/23.
//

import SwiftUI

@main
struct DessertAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(dessertListVM: DessertListViewModel())
        }
    }
}
// 
