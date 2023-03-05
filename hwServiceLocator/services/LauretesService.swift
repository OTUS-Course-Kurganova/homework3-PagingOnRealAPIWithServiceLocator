//
//  LauretesService.swift
//  hwServiceLocator
//
//  Created by Alexandra Kurganova on 15.01.2023.
//

import SwiftUI
import Network

protocol LaureteServiceProtocol {
    var isLoading: Bool { get set }

    func clear()
    func getLaureates(category: DefaultAPI.NobelPrizeCategory_laureatesGet,
                      completion: @escaping ([LaureateDataSource]) -> Void)
}

final class LaureteService: LaureteServiceProtocol {
    var isLoading = false
    var laureates: [LaureateDataSource] = []

    fileprivate let limit = 25

    func getLaureates(category: DefaultAPI.NobelPrizeCategory_laureatesGet,
                      completion: @escaping ([LaureateDataSource]) -> Void) {
        self.isLoading = isLoading == true
        fetchLaureates(category: category) { data in
            completion(data)
        }
    }

    fileprivate func fetchLaureates(category: DefaultAPI.NobelPrizeCategory_laureatesGet,
                                    completion: @escaping ([LaureateDataSource]) -> Void) {
        DefaultAPI.laureatesGet(offset: laureates.count, limit: limit, nobelPrizeCategory: category) { [weak self] data, error in
            guard let self = self, let data = data, let laureates = data.laureates else { return }
            laureates.forEach {
                self.laureates.append(.init(laureate: $0))
                completion(self.laureates)
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
