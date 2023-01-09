//
//  NetworkParams.swift
//  DessertApp
//
//  Created by Meder iZimov on 1/8/23.
//

import Foundation

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
            queryItems.append(URLQueryItem(name: "i", value: "\(path)"))
            components?.queryItems = queryItems
            return components?.url
        }
    }
}
