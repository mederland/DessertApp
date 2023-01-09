//
//  PageResult.swift
//  DessertApp
//
//  Created by Meder iZimov on 1/8/23.
//

import Foundation

// MARK: - PageResult
struct PageResult: Decodable {
    let meals: [Meal]
}

struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

