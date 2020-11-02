//
//  ProductWidgetViewModel.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import SwiftUI
class ProductWidgetViewModel: BaseViewModel {
    @Published var productName: String?
    @Published var productPrice: Int?
    @Published var productCurrency: Currency?
    
    init(product: Product){
        super.init()
        self.productName = product.name
        self.productPrice = product.price?.amount
        self.productCurrency = product.price?.currency
    }
}
