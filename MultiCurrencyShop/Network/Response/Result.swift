//
//  Result.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}

enum TupleResult<T, A , U> where U: Error  {
    case success(T, A)
    case failure(U)
}
