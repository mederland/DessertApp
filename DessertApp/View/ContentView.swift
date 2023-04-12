//
//  ContentView.swift
//  DessertApp
//
//  Created by Meder iZimov on 4/12/23.
//

import SwiftUI

struct ContentView<T: DessertListViewModelType>: View {
    @ObservedObject var dessertListVM: T
    @State private var showDetailView = false
    @State private var selectedIndex = 0
    
    var body: some View {
        GeometryReader { geo in
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 5)
            NavigationView {
                ZStack {
                    Image("Dessert")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        .opacity(1.0)
                        .blur(radius: 5)
                    content
                }
            }
            .padding(0)
        }
//
    }
    
    @ViewBuilder
    var content: some View {
        VStack {
            Text("Desserts")
                .shadow(color: .pink, radius: 1)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            if self.dessertListVM.isLoading {
                ProgressView()
            } else {
                dessertList
            }
        }
    }
    
    @ViewBuilder
    var dessertList: some View {
        List {
            ForEach(0..<self.dessertListVM.desserts.count, id: \.self) { index in
                NavigationLink(destination: DessertDetailView(dessertVM: self.dessertListVM, index: index)) {
                    DessertView(dessertListVM: self.dessertListVM, index: index)
                        .onAppear {
                            self.dessertListVM.requestDessertsIfNeeded(index: index)
                        }
                        .background(Color.clear)
                }
            }
        }
        .font(.title3)
        .foregroundColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dessertListVM: DessertListViewModel())
    }
}
