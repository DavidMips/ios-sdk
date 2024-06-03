//
//  MipsNetworkUrls.swift
//  MIPS_iOS_SDK
//
//  Created by shyank on 30/04/24.
//

import Foundation


public struct MipsNetworkUrls {
    public let baseURl : String
    public let paymentConfirmationUrl : String
    public let paymentUrlGenerator : String
    
    public init(
        baseURl: String,
        paymentConfirmationUrl: String,
        paymentUrlGenerator : String
    ) {
        self.baseURl = baseURl
        self.paymentConfirmationUrl = paymentConfirmationUrl
        self.paymentUrlGenerator = paymentUrlGenerator
    }
    
    public init() {
        baseURl = "https://go.mips.mu/mipsit.php?c="
        paymentConfirmationUrl = "https://api.mips.mu/api/orders_management"
        paymentUrlGenerator = "https://my.mips.mu/api/load_payment_zone"
    
    }
    
    public static let defaultUrls = MipsNetworkUrls()
}
