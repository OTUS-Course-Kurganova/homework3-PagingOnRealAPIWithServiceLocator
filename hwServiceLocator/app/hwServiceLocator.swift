//
//  hwServiceLocator.swift
//  hwServiceLocator
//
//  Created by Sasha Kurganova on 21.12.2022.
//

import SwiftUI

@main
struct hwServiceLocatorApp: App {
    init() {
        Configurator.shared.setup()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LaureatesViewModel())
                .environmentObject(NobelPrizeViewModel())
                .environmentObject(SegmentedViewModel())
                .environmentObject(NavigationViewModel(easing: .default))
        }
    }
}
