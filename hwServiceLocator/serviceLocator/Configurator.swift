//
//  Configurator.swift
//  hwServiceLocator
//
//  Created by Alexandra Kurganova on 12.03.2023.
//

import Foundation

class Configurator {
    static let shared = Configurator()
    
    private init() {}
    
    func setup() {
        setupLaureateService()
        setupNobelPrizeService()
    }
    
    private func setupLaureateService() {
        let laureateService: LaureteServiceProtocol = LaureteService()
        ServiceLocator.shared.addService(service: laureateService)
    }

    private func setupNobelPrizeService() {
        let nobelPrizeService: NobelPrizeServiceProtocol = NobelPrizeService()
        ServiceLocator.shared.addService(service: nobelPrizeService)
    }
}
