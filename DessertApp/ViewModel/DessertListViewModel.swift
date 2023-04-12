//
//  DessertListViewModel.swift
//  DessertApp
//
//  Created by Meder iZimov on 4/12/23.
//

import Foundation
import Combine


protocol DessertListViewModelType: ObservableObject {
    var desserts: [Meal] { get }
    var detailDessert: [Dessert] {get}
    var isLoading: Bool { get }
    func requestDessertsIfNeeded(index: Int)
}

class DessertListViewModel: DessertListViewModelType {
    
    private let networkService: NetworkService
    private var subs = Set<AnyCancellable>()
    @Published var desserts: [Meal] = []
    @Published var detailDessert: [Dessert] = []
    var currentPage = ""
    @Published var isLoading: Bool = false
 
    init(network: NetworkService = NetworkManager()) {
        self.networkService = network
        self.requestDessertsIfNeeded(index: 0)
    }
    
    func requestDessertsIfNeeded(index: Int) {
        guard index == (self.desserts.count - 1) || self.desserts.isEmpty else { return }
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.requestDesserts()
        }
    }
    
    func requestDesserts() {
        self.networkService.getModel(url: NetworkParams.popularDesserts(self.currentPage).url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] (page: PageResult) in
                self?.desserts.append(contentsOf: page.meals)
                self?.isLoading = false
            }.store(in: &self.subs)
    }
}
