//
//  HeaderViewModel.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import Foundation
class HeaderViewModel: ObservableObject {
    @Published var selectedCurrency: Currency = .gbp
    @Published var rateTable: [String: Double] = [:]
    init() {
        self.loadCurrencyRate()
    }
    func getCurrentRate()->Double {
        return self.rateTable[self.selectedCurrency.rawValue] ?? 0.0
    }
    func loadCurrencyRate(){
        let service = CurrencyService()
        service.getCurrencyList(baseCurrency: "GBP") { (result) in
            switch result{
            case .success(let model):
                guard let rates = model?.rates, model?.base == "GBP" else {return}
                self.rateTable = rates.filter({
                    $0.key == Currency.gbp.rawValue || $0.key == Currency.usd.rawValue ||
                    $0.key == Currency.eur.rawValue || $0.key == Currency.chf.rawValue ||
                    $0.key == Currency.jpy.rawValue
                })
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
}
