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
    @State private var imageOpacity: Double = 0
    @State private var scrollViewProxy: ScrollViewProxy? = nil
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer(minLength: 2)
                ZStack(alignment: .center) {
                    Spacer(minLength: 2)
                    Image("Dessert")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        .opacity(1.0)
                        .blur(radius: 10)
                    VStack{
                        if let imageUrl = URL(string: dessertVM.desserts[index].strMealThumb) {
                            AsyncImage(url: imageUrl) { realImage in
                                realImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geo.size.width, height: geo.size.height * 0.25)
                                    .opacity(imageOpacity)
                                    .animation(Animation.easeIn(duration: 2.0), value: imageOpacity)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 200, height: 200, alignment: .center)
                            }
                            .onAppear {
                                imageOpacity = 1
                            }
                        }
                       
                        ScrollView {
                            Spacer().frame(height: geo.safeAreaInsets.top)
                            VStack(spacing: 16) {
                                Text(dessertVM.desserts[index].strMeal)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                VStack(alignment: .leading, spacing: 16) {
                                    HStack {
                                        Text("Country:")
                                            .font(.headline)
                                            .fontWeight(.medium)
                                        Text(mealGenerator.currentMeal?.area ?? "-")
                                            .font(.subheadline)
                                    }
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Ingredients:")
                                            .font(.headline)
                                            .fontWeight(.medium)
                                        ForEach(mealGenerator.currentMeal?.ingredients ?? [], id:\.self) { ingredient in
                                            Text("\(ingredient.name) - \(ingredient.measure)")
                                                .font(.subheadline)
                                        }
                                    }
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Instructions:")
                                            .font(.headline)
                                            .fontWeight(.medium)
                                        Text(mealGenerator.currentMeal?.instructions ?? "-")
                                            .font(.subheadline)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                    Spacer()
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .greatestFiniteMagnitude)
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(24)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                        }
                        .onAppear {
                            scrollViewProxy?.scrollTo(0)
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(
                    leading: EmptyView(),
                    trailing: Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.red)
                            .font(.title2)
                            .shadow(color: .white, radius: 1)
                    })
                )
                .edgesIgnoringSafeArea(.top)
                .onAppear{
                    mealGenerator.fetchExactMeal(i: self.dessertVM.desserts[index].idMeal)
                }
            }
        }
    }
}

