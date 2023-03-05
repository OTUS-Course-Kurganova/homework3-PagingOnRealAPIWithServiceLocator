//
//  OthersNobelPrizesInYearView.swift
//  hwServiceLocator
//
//  Created by Alexandra Kurganova on 25.02.2023.
//

import SwiftUI

struct OthersNobelPrizesInYearView: View {
    @EnvironmentObject private var navigation: NavigationViewModel
    @EnvironmentObject var viewModel: NobelPrizeViewModel

    var body: some View {
        ScrollView {
            VStack {
                configureTitle("Category: \(viewModel.dataSource.first?.category ?? "unknown")")
                .padding(.top, 20)
            Divider()
                ForEach(viewModel.dataSource) { prize in
                configureSectionsInfo(prize: prize)
            }
                configureBackStack()
            }
        }
    }
    
    fileprivate func configureTitle(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 25))
            .fontWeight(.bold)
            .foregroundColor(.orange)
            .padding(.bottom, 30)
            .multilineTextAlignment(.center)
    }
    
    fileprivate func configureSectionsInfo(prize: NobelPrizeDataSource) -> some View {
        Group {
            configureSectionInfo(title: "Год выигрыша: ", info: prize.awardYear)
            configureSectionInfo(title: "Сумма выигрыша: ", info: prize.amount.formatted())
            configureSectionInfo(title: "Статус: ", info: prize.status.rawValue)
            configureSectionInfo(title: "Мотивационная речь: ", info: prize.motivation)
            Divider()
                .padding(.top, 15)
                .padding(.bottom, 15)
        }
    }
    
    fileprivate func configureSectionInfo(title: String, info: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.leading, 15)
            Text(info)
                .font(.system(size: 16))
                .multilineTextAlignment(.leading)
                .padding(.trailing, 15)
        }
    }
    
    fileprivate func configureBackStack() -> some View {
        Group {
            comeBack
                .padding(.bottom, 10)
            comeBackToRoot
        }
    }

    fileprivate var comeBack: some View {
        Button {
            navigation.pop()
        } label: {
            Text("Назад")
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .font(.system(size: 14))
        }
        .padding(.top, 50)
    }

    fileprivate var comeBackToRoot: some View {
        Button {
            navigation.pop(destination: .poptoRoot)
        } label: {
            Text("Назад к списку лауреатов")
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .font(.system(size: 14))
        }
    }
}

struct OthersNobelPrizesInYearView_Previews: PreviewProvider {
    static var previews: some View {
        OthersNobelPrizesInYearView()
    }
}
