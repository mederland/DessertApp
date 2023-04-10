//
//  ContentView.swift
//  DessertApp
//
//  Created by Meder iZimov on 1/8/23.
//.background(Color.white.opacity(0.6))

import SwiftUI

struct ContentView<T: DessertListViewModelType>: View {
    @ObservedObject var dessertListVM: T
    
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
//                        .blur(radius: 20)
                    content
                }
            }
        }
        .padding(0)
    }

    @ViewBuilder
    private var content: some View {
        VStack {
            Text("Desserts")
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
    private var dessertList: some View {
        List {
            ForEach(0..<self.dessertListVM.desserts.count, id: \.self) { index in
                NavigationLink(destination: DessertDetailView(dessertVM: self.dessertListVM, index: index)) {
                    DessertView(dessertListVM: self.dessertListVM, index: index)
                        .background(Color.clear)
//                        .opacity(0.6) // set opacity for each cell
                        .onAppear {
                            self.dessertListVM.requestDessertsIfNeeded(index: index)
                        }
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
