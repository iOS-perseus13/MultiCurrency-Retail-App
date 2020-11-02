//
//  HomeView.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var bottomViewModel: BottomViewModel
    @ObservedObject var headerViewModel: HeaderViewModel
    @ObservedObject var productListViewModel: ProductListViewModel
    @ObservedObject var checkoutViewModel: CheckOutViewModel
    var body: some View {
        VStack {
            HeaderView(headerViewModel: self.headerViewModel, bottomViewModel: self.bottomViewModel)
                .padding([.leading, .trailing, .top])
                .background(Color.gray.opacity(0.2))
            GeometryReader { geometry in
                if self.bottomViewModel.viewToShow == .home {
                    ProductListView(productListViewModel: self.productListViewModel, headerViewModel: self.headerViewModel, checkoutViewModel: self.checkoutViewModel)
                }
                else {
                    CheckOutView(checkoutViewModel: self.checkoutViewModel, headerViewModel: self.headerViewModel)
                        .background(Color.yellow)
                }
            }
            BottomView(bottomViewModel: self.bottomViewModel, checkoutViewModel: checkoutViewModel)
                .background(Color.gray.opacity(0.2))
                .edgesIgnoringSafeArea(.all)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
