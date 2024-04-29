//
//  NetworkAdaptor.swift
//  MIPS_iOS_SDK
//
//  Created by shyank on 30/04/24.
//

import Foundation
import Alamofire


public class NetworkAdaptor {
    
    private init() {}
    
    public static func checkPaymentStatus(
        mipsNetworkURl : MipsNetworkUrls ,
        merchant : MerchantDetails ,
        credentials : MerchantCredentials ,
        orderID : String ,
        completion : @escaping ( (_ isPaymentCompleted : Bool) -> Void) ,
        errorHandler : @escaping  ( (_ errorString : String) -> Void )
    ){
        let json = [
            "authentify" : [
                "id_merchant" : merchant.sIdMerchant ,
                "id_entity" : merchant.id_entity ,
                "id_operator" : merchant.id_operator ,
                "operator_password" : merchant.operator_password ,
            ] ,
            "instruction" : "get_order_all_data" ,
            "order" : [
                "id_order" : orderID
            ]
        ] as [String : Any]
        
        let (body , encodeError) = JSONCoder.encodeJson(json: json)
        
        if let error = encodeError {
            errorHandler(error.localizedDescription)
            return
        }
        
        AF.upload(
            body ?? .init(),
            to: mipsNetworkURl.paymentConfirmationUrl ,
            method: .post ,
            headers: .init([
                .init(
                    name: "Authorization",
                    value: "Basic \(getBasicAuthWithusernamePassword(username: credentials.username, password: credentials.password))"
                )
            ])
        )
        .response { afData in
            if let error = afData.error {
                errorHandler(error.localizedDescription)
                return
            }
            guard let data = afData.data
            else{
                errorHandler("no data found from server")
                return
            }
            let (json , err) = JSONCoder.decodeJson(data: data)
            if let err = err {
                errorHandler(err.localizedDescription)
                return
            }
            let status = json["order_status"] as? String  ?? ""
            if status.lowercased() == "success" {
                completion(true)
                return
            }
            completion(false)
        }
    }
    
    
    
    private static func getBasicAuthWithusernamePassword(username : String , password : String) -> String {
        let credentials = "\(username):\(password)"
        if let credentialsData = credentials.data(using: .utf8) {
            let base64Credentials = credentialsData.base64EncodedString()
            return base64Credentials
        }
        return ""
    }
}
