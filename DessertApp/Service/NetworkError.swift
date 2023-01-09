//
//  NetworkError.swift
//  DessertApp
//
//  Created by Meder iZimov on 1/8/23.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidStatusCode(Int)
    case generalError(Error)
}
