//
//  ProductListView.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject var productListViewModel: ProductListViewModel
    @ObservedObject var headerViewModel: HeaderViewModel
    @ObservedObject var checkoutViewModel: CheckOutViewModel
    var body: some View {
        LoadingView(isShowing: self.$productListViewModel.isCalculating) {
            List {
                ForEach(self.productListViewModel.modifiedList, id: \.self) { item in
                    Section(header: Text(item.sectionName.uppercased()).bold().frame(height: 50)) {
                        ForEach(item.products, id: \.self) { product in
                            HStack{
                                HStack{
                                    ProductImageView(urlString: product.productImage)
                                    HStack{
                                        Text(product.name ?? "")
                                            .font(.headline)
                                        Spacer()
                                    }
                                    HStack{
                                        if product.price?.amount != nil {
                                            Image(systemName: self.headerViewModel.selectedCurrency.icon)
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                        
                                            Text(self.getPriceString(product: product))
                                        }
                                         Spacer()
                                     }
                                }
                                HStack{
                                    AddToBasketView()
                                    .padding()
                                }.onTapGesture {
                                    self.checkoutViewModel.addProduct(product: product)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear{
            UITableView.appearance().tableFooterView = UIView()
        }
    }
    private func getPriceString(product: Product)->String{
        guard let price = product.price?.amount else { return ""}
        let rate = self.headerViewModel.getCurrentRate()
        return price.toString(conversionRate: rate)
    }
}

struct AddToBasketView: View {
    var body: some View{
        Button(action: {
        }) {
            Image(systemName: "cart.badge.plus")
                .resizable()
                .frame(width: 35, height: 30)
        }
        
    }
}
