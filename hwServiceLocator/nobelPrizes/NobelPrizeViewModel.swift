//
//  NobelPrizeViewModel.swift
//  hwServiceLocator
//
//  Created by Alexandra Kurganova on 25.02.2023.
//

import SwiftUI
import Network

protocol NobelPrizeViewModelProtocol {
    var isLoading: Bool { get set }

    func getNobelPrizes(year: Int, category: ScienceCategory)
}

final class NobelPrizeViewModel: NobelPrizeViewModelProtocol, ObservableObject {
    var isLoading: Bool = false
    @Published var dataSource: [NobelPrizeDataSource] = []

    fileprivate let service = NobelPrizeService()
    fileprivate var transformedCategory: DefaultAPI.NobelPrizeCategory_laureatesGet?

    func getNobelPrizes(year: Int, category: ScienceCategory) {
        transform(category: category)
        getFromService(year: year)
    }

    func transform(category: ScienceCategory) {
        transformedCategory = convertCategories(category: category)
    }

    fileprivate func convertCategories(category: ScienceCategory) -> DefaultAPI.NobelPrizeCategory_laureatesGet {
        switch category {
            case .chemistry: return .che
            case .medicine: return .med
        }
    }

    fileprivate func getFromService(year: Int) {
        self.isLoading = service.isLoading

        guard let category = transformedCategory else {
            service.clear()
            return
        }
        service.clear()

        service.getNobelPrizes(year: year) { data in
            let dataSource = data.filter {
                let cat = self.transformServiceCategory($0.category)
                return cat.rawValue == category.rawValue
            }
            self.dataSource = dataSource
        }
    }
    
    fileprivate func transformServiceCategory(_ category: String) -> DefaultAPI.NobelPrizeCategory_laureatesGet {
        switch category {
            case "Chemistry":
                return .che
            case "Medicine":
                return .med
            default:
                return .med
        }
    }
}
