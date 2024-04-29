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
    
    public init(
        baseURl: String,
        paymentConfirmationUrl: String
    ) {
        self.baseURl = baseURl
        self.paymentConfirmationUrl = paymentConfirmationUrl
    }
    
    public init() {
        baseURl = "https://go.mips.mu/mipsit.php?c="
        paymentConfirmationUrl = "https://api.mips.mu/api/orders_management"
    }
    
    public static let defaultUrls = MipsNetworkUrls()
}
