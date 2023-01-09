//
//  DessertDetailView.swift
//  DessertApp
//
//  Created by Meder iZimov on 1/9/23.
//

import SwiftUI
import Foundation
import Combine

struct DessertDetailView<T: DessertListViewModelType>: View {
    @ObservedObject var dessertVM: T
    let index: Int
    let i: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var mealGenerator = MealGenerator()
    var body: some View {
        NavigationView{
            ScrollView {
                HStack{
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
                }
                VStack {
                    HStack{
                        Text(dessertVM.desserts[index].strMeal)
                            .padding()
                    }
                    Spacer()
                    
                    if let area = mealGenerator.currentMeal?.area{
                        HStack{
                            Text("Country :")
                            Text(area)
                        }
                    }
                    Spacer()
                    if let ingredients = mealGenerator.currentMeal?.ingredients{
                        HStack{
                            Text ("Ingredients :")
                                .font(.title2)
                            Spacer()
                        }
                        ForEach(ingredients, id:\.self) { ingredient in
                            Text(ingredient.name + " - " + ingredient.measure)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    Spacer()
                    Spacer()
                    if let instructions = mealGenerator.currentMeal?.instructions{
                        Text ("Instructions :")
                            .font(.title2)
                        Spacer()
                        Text(instructions)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(Text("\(self.dessertVM.desserts[index].strMeal)"))
        .accentColor(.red)
        HStack{
            Button("Back")
            {
                self.presentationMode.wrappedValue.dismiss()
            }.foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0))
            Spacer()
            Button("")
            {
                mealGenerator.fetchExactMeal(i: self.dessertVM.desserts[index].idMeal)
            }.foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0))
                .onAppear{
                    mealGenerator.fetchExactMeal(i: self.dessertVM.desserts[index].idMeal)
                }
        }
        .padding(.horizontal)
        .padding(.horizontal)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailView(dessertVM: DessertListViewModel(), index: 0)
    }
}
