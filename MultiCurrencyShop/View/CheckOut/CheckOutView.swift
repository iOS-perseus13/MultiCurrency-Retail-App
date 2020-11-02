//
//  CheckOutView.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import SwiftUI

struct CheckOutView: View {
    @ObservedObject var checkoutViewModel: CheckOutViewModel
    @ObservedObject var headerViewModel: HeaderViewModel
    var body: some View {
        HStack {
            List {
                Section(header:
                    HStack{
                        HStack{
                            Text("Product")
                            Spacer()
                        }
                        .frame(width: 100)
                        Spacer()
                        Text("Units")
                        Spacer()
                        Text("Price")
                            .padding()
                    }
                    ,footer: HStack{
                        Text("Products: \(self.checkoutViewModel.totalItems)")
                        Spacer()
                        HStack{
                            Text("Total: ")
                            HStack{
                                Image(systemName: self.headerViewModel.selectedCurrency.icon)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }.frame(width: 25)
                            HStack{
                                Text("\(checkoutViewModel.totalPrice.toString(conversionRate: headerViewModel.getCurrentRate()))")
                            }
                            .frame(width: 50)
                        }
                    }
                ) {
                    ForEach(checkoutViewModel.products, id: \.self){ item in
                        HStack {
                            VStack(alignment:.leading ){
                                HStack{
                                    Text(item.item.name ?? "")
                                    Spacer()
                                }
                            }
                            .frame(width: 120)
                             Spacer()
                            HStack(alignment: .center, spacing: 10){
                                Button(action: {
                                }) {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                    .onTapGesture {
                                        self.checkoutViewModel.addProduct(product: item.item)
                                    }
                                }
                                Text("\(item.count)")
                                    .fontWeight(.bold)
                                Button(action: {
                                }) {
                                    Image(systemName: "minus.circle")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .onTapGesture {
                                            self.checkoutViewModel.removeProduct(product: item.item)
                                    }
                                }
                                Button(action: {
                                }) {
                                    Image(systemName: "trash")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.red)
                                        .onTapGesture {
                                            self.checkoutViewModel.removeAll(product: item.item)
                                    }
                                }
                                
                            }
                            Spacer()
                            HStack{
                                Image(systemName: self.headerViewModel.selectedCurrency.icon)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }.frame(width: 25)
                            HStack{
                                Text("\(self.checkoutViewModel.totalPrice(product: item).toString(conversionRate: self.headerViewModel.getCurrentRate()))")
                            }
                            .frame(width: 50)
                        }
                    }
                }
                
            }
        }
    }
}
