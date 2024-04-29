//
//  MerchantCredentials.swift
//  MIPS_iOS_SDK
//
//  Created by shyank on 30/04/24.
//

import Foundation

public class MerchantCredentials {
    public let username : String
    public let password : String
    
    public init(
        username: String,
        password: String
    ) {
        self.username = username
        self.password = password
    }
}
