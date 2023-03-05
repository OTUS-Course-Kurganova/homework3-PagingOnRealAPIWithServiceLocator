//
//  NobelPrizeDataSource.swift
//  hwServiceLocator
//
//  Created by Sasha Kurganova on 22.12.2022.
//

import SwiftUI
import Network

final class NobelPrizeDataSource {
    fileprivate let unknown = "unknown"

    let category: String
    let awardYear: String
    let amount: Int
    let status: NobelPrizePerLaureate.PrizeStatus
    let motivation: String

    init(prizePerLaureate: NobelPrizePerLaureate) {
        category = prizePerLaureate.categoryFullName?.en ?? unknown
        awardYear = prizePerLaureate.awardYear ?? unknown
        amount = prizePerLaureate.prizeAmount ?? 0
        motivation = prizePerLaureate.motivation?.en ?? unknown
        status = prizePerLaureate.prizeStatus ?? .restricted
    }

    init(prize: NobelPrize) {
        self.category = prize.category?.en ?? unknown
        self.awardYear = prize.awardYear ?? unknown
        self.amount = prize.prizeAmount ?? 0
        self.motivation = prize.topMotivation?.en ?? unknown
        self.status = .restricted
    }
}

extension NobelPrizeDataSource: Identifiable { }
