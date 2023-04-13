//
//  DessertView.swift
///  DessertApp
//
//  Created by Meder iZimov on 4/12/23.
//

import SwiftUI
import URLImage

struct DessertView<T: DessertListViewModelType>: View {
    
    @ObservedObject var dessertListVM: T
    let index: Int
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                if let imageUrl = URL(string: "\(self.dessertListVM.desserts[index].strMealThumb)") {
                    URLImage(imageUrl,
                             failure: { error, _ in
                                 PlaceholderImageView()
                             },
                             content: { image in
                                 image
                                     .renderingMode(.original)
                                     .resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: UIScreen.main.bounds.width - 32, height: 200)
                                     .cornerRadius(10)
                                     .opacity(1)
                                     .overlay(Color.black.opacity(0.3))
                             })
                } else {
                    PlaceholderImageView()
                }
                
                Text(dessertListVM.desserts[index].strMeal)
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding(.leading, 16)
                    .padding(.bottom, 16)
            }
            
            Spacer()
        }
        .background(Color.clear)
        .padding(.horizontal, 16)
        .background(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

struct PlaceholderImageView: View {
    var body: some View {
        Image(systemName: "photo")
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width - 32, height: 200)
            .cornerRadius(10)
            .opacity(0.5)
            .overlay(Color.black.opacity(0.3))
    }
}
