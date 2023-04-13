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
    @State private var searchText = ""
    
    var filteredDesserts: [Meal] {
        if searchText.isEmpty {
            return dessertListVM.desserts
        } else {
            return dessertListVM.desserts.filter { dessert in
                let contains = dessert.strMeal.localizedCaseInsensitiveContains(searchText)
                return contains
            }
        }
    }
    
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
        VStack{
            SearchBar(text: $searchText)
            List(filteredDesserts, id: \.idMeal) { dessert in
                NavigationLink(destination: DessertDetailView(dessertVM: self.dessertListVM, index: self.dessertListVM.desserts.firstIndex(where: { $0.idMeal == dessert.idMeal })!)) {
                    DessertView(dessertListVM: self.dessertListVM, index: self.dessertListVM.desserts.firstIndex(where: { $0.idMeal == dessert.idMeal })!)
                        .onAppear {
                            self.dessertListVM.requestDessertsIfNeeded(index: self.dessertListVM.desserts.firstIndex(where: { $0.idMeal == dessert.idMeal })!)
                        }
                }
            }
            .font(.title3)
            .foregroundColor(.blue)
        }
        .background(
            Image("Dessert")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(1.0)
                .blur(radius: 5)
        )
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 8) {
            TextField("Search", text: $text)
                .padding(.leading, 8)
                .padding(.vertical, 12)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 16)
            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                    .font(.system(size: 24))
            }
            .padding(.trailing, 16)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dessertListVM: DessertListViewModel())
    }
}
