//
//  Amount.swift
//  MIPS_iOS_SDK
//
//  Created by shyank on 30/04/24.
//

import Foundation


public class Amount {
    public let currency : Currency
    public let price : Int
    
    public init(
        currency: Currency,
        price: Int
    ) {
        self.currency = currency
        self.price = price
    }
}
