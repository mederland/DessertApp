//
//  DessertView.swift
//  DessertApp
//
//  Created by Meder iZimov on 1/8/23.
//

import SwiftUI
import Foundation
import Combine

struct DessertView<T: DessertListViewModelType>: View {
    
    @ObservedObject var dessertListVM: T
    let index: Int
    var i: String
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "\(self.dessertListVM.desserts[index].strMealThumb)")) { realImage in
                realImage
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
            } placeholder: {
                ProgressView()
                    .frame(width: 150, height: 150, alignment: .center)
            }
            .padding([.top, .bottom, .trailing], 8)
            Text(dessertListVM.desserts[index].strMeal)
                .padding([.top, .bottom, .trailing], 8)
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0))
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        DessertView(dessertListVM: DessertListViewModel(), index: 0, i: "")
    }
}
