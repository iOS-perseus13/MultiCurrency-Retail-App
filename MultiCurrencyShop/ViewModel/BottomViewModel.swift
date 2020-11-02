//
//  BottomViewModel.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import Foundation
enum ViewToshow{
    case home
    case checkout
}
class BottomViewModel: ObservableObject {
    @Published var viewToShow: ViewToshow
    init(){
        self.viewToShow = .home
    }
}
