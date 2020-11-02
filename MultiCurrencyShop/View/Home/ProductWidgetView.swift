//
//  ProductWidgetView.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import SwiftUI

struct ProductWidgetView: View {
    @ObservedObject var productWidgetViewModel: ProductWidgetViewModel
    @ObservedObject var headerViewModel: HeaderViewModel
    var body: some View {
        HStack {
            VStack{
                HStack{
                    Text(productWidgetViewModel.productName ?? "")
                        .font(.headline)
                    Spacer()
                }
                HStack{
               //     if self.productWidgetViewModel.productPrice != nil {
                        Image(systemName: headerViewModel.selectedCurrency.icon)
                        Text(self.productWidgetViewModel.productPrice!.toString(conversionRate: headerViewModel.rateTable[headerViewModel.selectedCurrency.rawValue] ?? 1.0))
                  //  }
                    Spacer()
                }
            }
        }
    }
}
