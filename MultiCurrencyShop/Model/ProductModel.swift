//
//  ProductModel.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import Foundation
// MARK: - Product
struct Product: Codable, Hashable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id && lhs.price?.currency == rhs.price?.currency
    }
    
    let id: Int
    let name: String?
    let price: Price?
    let container: String?
    var productImage: String?
}

// MARK: - Price
struct Price: Codable, Hashable {
    let amount: Int
    let currency: Currency?
}

enum Currency: String, Codable {
    case eur = "EUR"
    case gbp = "GBP"
    case usd = "USD"
    case chf = "CHF"
    case jpy = "JPY"
    var icon: String {
        switch self {
        case .eur: return "eurosign.circle"
        case .gbp: return "sterlingsign.circle"
        case .usd: return "dollarsign.circle"
        case .jpy: return "yensign.circle"
        case .chf: return "francsign.circle"
        }
    }
}

typealias Products = [Product]

// MARK:- ProductImage
typealias ProductImage = [String: String]

// MARK: - ModifiedList
struct ModifiedList: Hashable{
    var id = UUID()
    var sectionName: String
    var products: Products
}

// MARK:- Checkout Model
struct CheckoutItem: Hashable{
    let item: Product
    var count: Int
}
