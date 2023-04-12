//
//  NetworkError.swift
//  DessertApp
//
//  Created by Meder iZimov on 4/12/23.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidStatusCode(Int)
    case generalError(Error)
}

