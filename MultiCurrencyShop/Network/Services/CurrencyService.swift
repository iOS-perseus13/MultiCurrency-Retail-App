//
//  CurrencyService.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import Foundation
protocol CurrencyServiceType {
    func getCurrencyList(baseCurrency: String?, completion: @escaping(Result<CurrencyRate?, APIError>)->Void)
}

class CurrencyService: CurrencyServiceType {
    let requestManager = RequestManager()
    
    func getCurrencyList(baseCurrency: String?, completion: @escaping(Result<CurrencyRate?, APIError>)->Void) {
        let resource = CurrencyAPIResource(baseCurrency: baseCurrency)
        guard let request = try? resource.makeRequest() else { return }
        requestManager.fetch(with: request, decode: { (json) -> CurrencyRate? in
            guard let currencyModel = json as? CurrencyRate else { return nil}
            return currencyModel
        }, completion: completion)
    }
}
