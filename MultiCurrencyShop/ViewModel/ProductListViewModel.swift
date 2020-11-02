//
//  ProductListViewModel.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import Foundation

class ProductListViewModel: BaseViewModel {
    private var products: Products = []
    private var productImages: ProductImage = [:]
    @Published var modifiedList: [ModifiedList] = []
    
    override init(){
        super.init()
        self.loadProductInfo()
    }
    
    func loadProductInfo(){
        let queue = OperationQueue()
        let combineProductInfo = BlockOperation {
            for image in self.productImages {
                var indexList = [Int]()
                for (index,product) in self.products.enumerated() {
                    if String(product.id) == image.key {
                        indexList.append(index)
                    }
                }
                for index in indexList{
                    let securedLink = image.value.split(separator: ":")
                    if let firstPart = securedLink.first, firstPart == "http", let lastPart = securedLink.last{
                        self.products[index].productImage = "https:" + lastPart
                    } else {
                        self.products[index].productImage = image.value
                    }
                }
            }
            self.createModifiedList()
        }
        
        let getProductImages = BlockOperation {
            let service = ProductService()
            service.getProductImge(productID: nil)  { (result) in
                switch result {
                case .success(let dictionary):
                    guard let dictionary = dictionary  else {return}
                    self.productImages = dictionary
                case .failure(let error):
                    self.isError = false
                    self.message = error.localizedDescription
                }
                queue.addOperation(combineProductInfo)
            }
        }
        
        let getProducts = BlockOperation {
            let service = ProductService()
            service.getProductList { (result) in
                switch result {
                case .success(let model):
                    guard let model = model else {
                        return
                    }
                    self.products = Array(Set(model.filter({$0.price?.currency == .gbp})))
                    queue.addOperation(getProductImages)
                case .failure(let error):
                    self.isError = true
                    self.message = error.localizedDescription
                }
            }
        }
        queue.addOperation(getProducts)
    }
    private func createModifiedList(){
        var list: [ModifiedList] = []
        let typesOfContainers = Set(self.products.compactMap({ $0.container}))
        for container in typesOfContainers {
            let items = self.products.filter {
                $0.container == container
            }.compactMap { $0 }
            let listItem = ModifiedList(sectionName: container, products: items )
            list.append(listItem)
        }
        self.modifiedList = list.sorted(by: {$0.sectionName < $1.sectionName })
        DispatchQueue.main.async {
            self.isCalculating = false
            self.isError = false
            self.message = nil
        }
    }
}
