//
//  HomeViewModel.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import Foundation
class HomeViewModel: BaseViewModel{
    @Published var currency: Currency
    init(defaultCurrency: Currency){
        self.currency = defaultCurrency
    }
}
