//
//  DetailResult.swift
//  DessertApp
//
//  Created by Meder iZimov on 1/6/23.
//

import Foundation

// MARK: - Detailk
struct DetailResult: Decodable {
    let meals: [Dessert]
}
struct Dessert: Decodable {
    let strMeal: String
    let strArea: String
    let strInstructions: String
}
