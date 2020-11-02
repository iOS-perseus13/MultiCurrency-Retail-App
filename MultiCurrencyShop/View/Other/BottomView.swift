//
//  FloatingButtonView.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import SwiftUI

struct BottomView: View {
    @ObservedObject var bottomViewModel: BottomViewModel
    @ObservedObject var checkoutViewModel: CheckOutViewModel
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack {
                Spacer()
                Image(systemName: "house")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(bottomViewModel.viewToShow == .home ? .blue : .none)
                    .onTapGesture {
                        self.bottomViewModel.viewToShow = .home
                }
                Spacer()
                Image(systemName: "cart")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(bottomViewModel.viewToShow == .checkout ? .blue : .none)
                    .onTapGesture {
                        self.bottomViewModel.viewToShow = .checkout
                }
                if checkoutViewModel.totalItems > 0 {
                    Text("\(checkoutViewModel.totalItems)")
                        .font(.caption)
                        .offset(x: -25, y: -20)
                        .foregroundColor(.red)
                }
                Spacer()
            }
            .padding()
        }
        .padding()
    }
}
