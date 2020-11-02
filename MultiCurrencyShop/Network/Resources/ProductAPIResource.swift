//
//  ProductAPIResource.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import Foundation
enum ProductAPIEndpoints {
    case productList
    case productImage
    case currencyRate
}
struct ProductAPIResource {
    var productID: String?
    var endPoint: ProductAPIEndpoints
}

extension ProductAPIResource: ResourceType {
    var baseURL: URL {
        guard let url = URL(string: URLList.productAPI.baseURL) else {
            fatalError(baseURLFailureMessage)
        }
        return url
    }
    var path: String {
        switch endPoint {
        case .productList:
            return "/goods"
        case .productImage:
            guard let productID = productID else {
                return "/images"
            }
            return "/images/\(productID)"
        case .currencyRate:
            return "/currencies"
        }
    }
    var parameter: Parameters {
        return [String: String]()
    }
    var httpMethod: HTTPMethod {
        return .get
    }
    var task: HTTPTask {
        return .request
    }
}
