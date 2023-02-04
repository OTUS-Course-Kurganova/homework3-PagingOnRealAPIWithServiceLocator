//
//  LaureatesViewModel.swift
//  hwServiceLocator
//
//  Created by Sasha Kurganova on 21.12.2022.
//

import SwiftUI
import Network

protocol LaureatesViewModelProtocol {
    var dataSource: [LaureateDataSource]? { get set }

    func transform(category: ScienceCategory)
    func getLaureates(category: ScienceCategory)
}

final class LaureatesViewModel: ObservableObject {
    fileprivate let service = LaureteService()

    fileprivate var currentCategory: ScienceCategory = .chemistry
    fileprivate var transformedCategory: DefaultAPI.NobelPrizeCategory_laureatesGet?

    var dataSource: [LaureateDataSource]?

    func  transform(category: ScienceCategory) {
        transformedCategory = convertCategories(category: category)
    }

    fileprivate func convertCategories(category: ScienceCategory) -> DefaultAPI.NobelPrizeCategory_laureatesGet {
        switch category {
            case .chemistry: return .che
            case .medicine: return .med
        }
    }

    func getLaureates(category: ScienceCategory) {
        prepare(category: category)
        getFromService()
    }

    fileprivate func prepare(category: ScienceCategory) {
        if category != currentCategory {
            service.clear()
            currentCategory = category
        }
        transform(category: category)
    }

    fileprivate func getFromService() {
        guard let category = transformedCategory else {
            service.clear()
            return
        }
        self.dataSource = service.getLaureates(category: category)
    }

}
