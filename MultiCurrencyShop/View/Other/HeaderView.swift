//
//  FloatingHeaderView.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    @ObservedObject var headerViewModel: HeaderViewModel
    @ObservedObject var bottomViewModel: BottomViewModel
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                Image(systemName: Currency.gbp.icon)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(headerViewModel.selectedCurrency == .gbp ? .blue : .none)
                    .onTapGesture {
                        self.headerViewModel.selectedCurrency = .gbp
                }
                Spacer()
                Image(systemName: Currency.usd.icon)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(headerViewModel.selectedCurrency == .usd ? .blue : .none)
                    .onTapGesture {
                        self.headerViewModel.selectedCurrency = .usd
                }
                Spacer()
                Image(systemName: Currency.eur.icon)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(headerViewModel.selectedCurrency == .eur ? .blue : .none)
                    .onTapGesture {
                        self.headerViewModel.selectedCurrency = .eur
                }
                Spacer()
                Image(systemName: Currency.chf.icon)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(headerViewModel.selectedCurrency == .chf ? .blue : .none)
                    .onTapGesture {
                        self.headerViewModel.selectedCurrency = .chf
                }
            }
            .padding()
        }
        .padding()
    }
}
