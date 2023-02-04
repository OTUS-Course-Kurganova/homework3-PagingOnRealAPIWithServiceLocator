//
//  LauretesService.swift
//  hwServiceLocator
//
//  Created by Alexandra Kurganova on 15.01.2023.
//

import SwiftUI
import Network

protocol LaureteServiceProtocol {
    func clear()
    func getLaureates(category: DefaultAPI.NobelPrizeCategory_laureatesGet) -> [LaureateDataSource]
}

final class LaureteService: LaureteServiceProtocol {
    @Published var laureates: [LaureateDataSource] = []

    fileprivate let limit = 25
    fileprivate var isLoading = false

    func getLaureates(category: DefaultAPI.NobelPrizeCategory_laureatesGet) -> [LaureateDataSource] {
        isLoading = true
        fetchLaureates(category: category)
        return laureates
    }

    fileprivate func fetchLaureates(category: DefaultAPI.NobelPrizeCategory_laureatesGet) {
        DefaultAPI.laureatesGet(offset: laureates.count, limit: limit, nobelPrizeCategory: category) { [weak self] data, error in
            guard let self = self, let data = data, let laureates = data.laureates else { return }
            laureates.forEach {
                self.laureates.append(.init(laureate: $0))
            }
        }
    }

    func clear() {
        clearLaureates()
    }

    fileprivate func clearLaureates() {
        laureates.removeAll()
    }
}
