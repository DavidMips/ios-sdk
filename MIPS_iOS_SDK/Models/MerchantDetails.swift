//
//  MerchantDetails.swift
//  MIPS_iOS_SDK
//
//  Created by shyank on 30/04/24.
//

import Foundation


public class MerchantDetails {
    
    public let sIdMerchant : String
    public let sIdForm : String
    public let salt : String
    public let sCipherKey : String
    public let id_entity : String
    public let id_operator : String
    public let operator_password : String
    
    public init(
        sIdMerchant: String,
        sIdForm: String,
        salt: String,
        sCipherKey: String,
        id_entity: String,
        id_operator: String,
        operator_password: String
    ) {
        self.sIdMerchant = sIdMerchant
        self.sIdForm = sIdForm
        self.salt = salt
        self.sCipherKey = sCipherKey
        self.id_entity = id_entity
        self.id_operator = id_operator
        self.operator_password = operator_password
    }
    
}
