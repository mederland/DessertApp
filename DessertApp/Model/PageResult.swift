//
//  PageResult.swift
//  DessertApp
//
//  Created by Meder iZimov on 4/12/23.
//

import Foundation

struct PageResult: Decodable {
    let meals: [Meal]
}

struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

