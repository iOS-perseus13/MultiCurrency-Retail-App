//
//  CheckoutViewModel.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 08/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import Foundation

class CheckOutViewModel: ObservableObject {
    @Published var products: [CheckoutItem] = []
    
    var totalPrice: Int {
        let total = products.compactMap { $0 }.reduce(0){$0 + ($1.count) * ($1.item.price?.amount ?? 0)}
        return total
    }
    var totalItems: Int {
        let total = products.compactMap { $0 }.reduce(0){$0 + ($1.count)}
        return total
    }
    func totalItems(product: CheckoutItem)->Int{
        let total = products.filter { $0 == product}.reduce(0){$0 + ($1.count)}
        return total
    }
    func totalPrice(product: CheckoutItem)->Int{
        let total = self.products.filter { $0 == product}.reduce(0){$0 + ($1.count) * ($1.item.price?.amount ?? 0)}
        return total
    }
    func addProduct(product: Product){
        guard let index = self.products.firstIndex(where: {$0.item.id == product.id }) else {
            self.products.append(CheckoutItem(item: product, count: 1))
            return
        }
        self.products[index].count += 1
    }
    func addProduct(product: CheckoutItem){
        guard let index = self.products.firstIndex(where: {$0 == product}) else {
            var tempItem = product
            tempItem.count = 1
            self.products.append(tempItem)
            return
        }
        self.products[index].count += 1
    }
    func removeProduct(product: Product){
        guard let index = self.products.firstIndex(where: {$0.item.id == product.id }) else {
            return
        }
        if self.products[index].count > 1 {
            self.products[index].count -= 1
        } else {
            self.products.remove(at: index)
        }
    }
    func removeProduct(product: CheckoutItem){
        guard let index = self.products.firstIndex(where: {$0 == product }) else {
            return
        }
        if self.products[index].count > 1 {
            self.products[index].count -= 1
        } else {
            self.products.remove(at: index)
        }
    }
    
    func removeAll(product: Product){
        guard let index = self.products.firstIndex(where: {$0.item.id == product.id }) else {
            return
        }
        self.products.remove(at: index)
    }
    func emptyCart(){
        self.products.removeAll()
    }
}
