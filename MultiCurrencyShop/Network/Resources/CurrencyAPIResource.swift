//
//  CurrencyAPIResource.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import Foundation
struct CurrencyAPIResource {
    var baseCurrency: String?
}

extension CurrencyAPIResource: ResourceType {
    var baseURL: URL {
        guard let url = URL(string: URLList.currencyAPI.baseURL) else {
            fatalError(baseURLFailureMessage)
        }
        return url
    }
    var path: String {
        return "/latest"
    }
    var parameter: Parameters {
        var parameter = [String: String]()
        guard let base = baseCurrency else {
            return parameter
        }
        parameter["base"] = base
        return parameter
    }
    var httpMethod: HTTPMethod {
        return .get
    }
    var task: HTTPTask {
        return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: parameter)
    }
}
