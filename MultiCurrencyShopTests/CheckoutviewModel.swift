//
//  CheckoutviewModel.swift
//  MultiCurrencyShopTests
//
//  Created by Viraj Padia on 08/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import XCTest
@testable import MultiCurrencyShop

class CheckoutviewModel: XCTestCase {
    var viewModelUnderTest: CheckOutViewModel?

    override func setUpWithError() throws {
        viewModelUnderTest = CheckOutViewModel()
        
    }

    override func tearDownWithError() throws {
        viewModelUnderTest = nil
    }

    func testExample() throws {
        XCTAssertEqual(viewModelUnderTest?.products.count, viewModelUnderTest?.totalItems)
    }
}
