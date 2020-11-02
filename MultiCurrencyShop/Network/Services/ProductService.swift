//
//  ProductService.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import Foundation
protocol ProductServiceType {
    
    func getProductList(completion: @escaping(Result<Products?, APIError>)->Void)
    func getProductImge(productID: Int?, completion:@escaping(Result<ProductImage?, APIError>)->Void)
    //func getCurrencyList()
}

class ProductService: ProductServiceType {
    let requestManager = RequestManager()
    
    func getProductList(completion: @escaping (Result<Products?, APIError>) -> Void) {
        let resource = ProductAPIResource(productID: nil, endPoint: .productList)
        guard let request = try? resource.makeRequest() else { return }
        requestManager.fetch(with: request, decode: { (json) -> Products? in
            guard let productsModel = json as? Products else { return nil}
            return productsModel
        }, completion: completion)
    }
    
    func getProductImge(productID: Int?, completion: @escaping (Result<ProductImage?, APIError>) -> Void) {
        let resource = ProductAPIResource(productID: nil, endPoint: .productImage)
        guard let request = try? resource.makeRequest() else { return }
        requestManager.fetch(with: request, decode: { (json) -> ProductImage? in
            guard let productsModel = json as? ProductImage else { return nil}
            return productsModel
        }, completion: completion)
    }
}
