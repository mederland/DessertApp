//
//  DetailResult.swift
//  DessertApp
//
//  Created by Meder iZimov on 1/9/23.
//

import Foundation

// MARK: - Detailk
struct MealData: Decodable {
    let meals: [Dessert]
    
}
struct Dessert: Decodable {
    let idMeal: String
    let name: String
    let area: String
    let instructions: String
    let ingredients: [Ingredient]
}
struct Ingredient: Decodable, Hashable {
    let name: String
    let measure: String
}


extension Dessert {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let mealDict = try container.decode([String: String?].self)
        
        var index = 1
        var ingredients: [Ingredient]  = []
        
        while let ingredient = mealDict["strIngredient\(index)"] as? String,
              let measure = mealDict["strMeasure\(index)"] as? String,
              !ingredient.isEmpty,
              !measure.isEmpty {
            ingredients.append(.init(name: ingredient, measure: measure))
            index += 1
        }
        self.ingredients = ingredients
        idMeal = mealDict["idMeal"] as? String ?? ""
        name = mealDict["strMeal"] as? String ?? ""
        area = mealDict["strArea"] as? String ?? ""
        instructions = mealDict["strInstructions"] as? String ?? ""
    }
}
