//
//  NobelPrizeService.swift
//  hwServiceLocator
//
//  Created by Alexandra Kurganova on 04.02.2023.
//

import Foundation
import Network

protocol NobelPrizeServiceProtocol {
    var isLoading: Bool { get set }

    func clear()
    func getNobelPrizes(year: Int, completion: @escaping ([NobelPrizeDataSource]) -> Void)
}

final class NobelPrizeService: NobelPrizeServiceProtocol {
    var isLoading = false

    var nobelPrizes = [NobelPrizeDataSource]()

    func getNobelPrizes(year: Int, completion: @escaping ([NobelPrizeDataSource]) -> Void) {
        self.isLoading = isLoading == true
        fetch(year: year) { data in
            completion(data)
        }
    }

    fileprivate func fetch(year: Int, completion: @escaping ([NobelPrizeDataSource]) -> Void) {
        DefaultAPI.nobelPrizesGet(nobelPrizeYear: year) { [weak self] data, error in
            guard let self = self, let data = data, let prizes = data.nobelPrizes else { return }
            for prize in prizes {
                self.nobelPrizes.append(.init(prize: prize))
                completion(self.nobelPrizes)
            }
        }
    }

    func clear() {
        clearNobelPrizes()
    }

    fileprivate func clearNobelPrizes() {
        nobelPrizes.removeAll()
    }
}
