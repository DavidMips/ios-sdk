//
//  MipsPaymentJSON.swift
//  MIPS_iOS_SDK
//
//  Created by shyank on 30/04/24.
//

import Foundation




public class MipsPaymentJSON : Codable {
    var id_form : String = ""
    var id_order: String = ""
    var amount : Int = 99
    var currency : String = ""
    var checksum : String = ""
    var additional_param : [String : String] = .init()
}
