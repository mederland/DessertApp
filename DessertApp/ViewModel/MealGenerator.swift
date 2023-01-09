//
//  MealGenerator.swift
//  DessertApp
//
//  Created by Meder iZimov on 1/8/23.
//

import Foundation
import Combine

final class MealGenerator: ObservableObject {
    
    @Published var currentMeal: Dessert?
    private var cancellable: AnyCancellable?
//    ViewModel
    func fetchExactMeal(i: String) {
        cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(i)")!)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { data, _ in
                if let mealData = try? JSONDecoder().decode(MealData.self, from: data) {
                    self.currentMeal = mealData.meals.first
                }
            }
    }
}
