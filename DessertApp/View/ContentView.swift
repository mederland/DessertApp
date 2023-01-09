//
//  ContentView.swift
//  DessertApp
//
//  Created by Meder iZimov on 1/8/23.
//

import SwiftUI
import Combine

struct ContentView<T: DessertListViewModelType>: View {
    
    @ObservedObject var dessertListVM: T
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Desserts")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                List {
                    ForEach(0..<self.dessertListVM.desserts.count, id: \.self) { index in
                        NavigationLink(destination: DessertDetailView(dessertVM: self.dessertListVM, index: index)) {
                            DessertView(dessertListVM: self.dessertListVM, index: index, i: self.dessertListVM.desserts[index].idMeal)
                                .onAppear {
                                    self.dessertListVM.requestDessertsIfNeeded(index: index)
                                }
                        }
                    }
                    
                    if self.dessertListVM.isLoading {
                        ProgressView()
                    }
                }
                .font(.title3)
                .foregroundColor(.gray)
            }
        }
        .padding(0)
    }
}
// TODO: Figure out removing space at top of NavigationView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dessertListVM: DessertListViewModel())
    }
}
