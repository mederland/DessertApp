//
//  NetworkParams.swift
//  DessertApp
//
//  Created by Meder iZimov on 4/12/23.
//

import Foundation
import Combine

final class NetworkParam: ObservableObject {

    @Published var currentMeal: Dessert?
    private var cancellable: AnyCancellable?
    
    
    func fetchExactMeal(index: String) {
        cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(index)")!)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: MealData.self, decoder: JSONDecoder())
            .map { $0.meals.first }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching meal: \(error.localizedDescription)")
                }
            }, receiveValue: { meal in
                self.currentMeal = meal
            })
    }
}

enum NetworkParams {
    
    private struct NetworkConstants {
        static let popularDessertsBase = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        static let dessertDetailBase = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    }
    case popularDesserts(String)
    case dessertDetail(String)

    var url: URL? {
        switch self {
        case .popularDesserts(let page):
            return URL(string: NetworkConstants.popularDessertsBase + page)
            
        case .dessertDetail(let path):
            var components = URLComponents(string: NetworkConstants.dessertDetailBase)
            var queryItems: [URLQueryItem] = []
            queryItems.append(URLQueryItem(name: "index", value: "\(path)"))
            components?.queryItems = queryItems
            return components?.url
        }
    }
}
