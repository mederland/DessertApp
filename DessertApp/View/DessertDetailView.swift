//
//  DessertDetailView.swift
//  DessertApp
//
//  Created by Meder iZimov on 1/9/23.
//

import SwiftUI

struct DessertDetailView<T: DessertListViewModelType>: View {
    @ObservedObject var dessertVM: T
    let index: Int
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var mealGenerator = NetworkParam()
    
    var body: some View {
        NavigationView{
            ScrollView {
                AsyncImage(url: URL(string: "\(self.dessertVM.desserts[index].strMealThumb)")) { realImage in
                    realImage
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(16)
                } placeholder: {
                    ProgressView()
                        .frame(width: 300, height: 300, alignment: .center)
                }
                .padding([.top, .bottom, .trailing], 8)
                VStack {
                    Text(dessertVM.desserts[index].strMeal)
                        .padding()
                    
                    Spacer()
                    
                    HStack{
                        Text("Country:")
                        Text(mealGenerator.currentMeal?.area ?? "-")
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading){
                        Text("Ingredients:")
                            .font(.title2)
                        
                        ForEach(mealGenerator.currentMeal?.ingredients ?? [], id:\.self) { ingredient in
                            Text(ingredient.name + " - " + ingredient.measure)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading){
                        Text("Instructions:")
                            .font(.title2)
                        Text(mealGenerator.currentMeal?.instructions ?? "-")
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(Text("\(self.dessertVM.desserts[index].strMeal)"))
            .accentColor(.red)
            .onAppear{
                mealGenerator.fetchExactMeal(i: self.dessertVM.desserts[index].idMeal)
            }
        }
        .padding(.horizontal)
    }
}

