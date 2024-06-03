//
//  NetworkAdaptor.swift
//  MIPS_iOS_SDK
//
//  Created by shyank on 30/04/24.
//

import Foundation


public class NetworkAdaptor {
    
    private init() {}
    
    public static func checkPaymentStatus(
        mipsNetworkURl : MipsNetworkUrls ,
        merchant : MerchantDetails ,
        credentials : MerchantCredentials ,
        orderID : String
    ) async -> Bool {
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
            LogManager.shared.error(error.localizedDescription)
            return false
        }
        
        let req = NSMutableURLRequest(url: URL(string: mipsNetworkURl.paymentConfirmationUrl)!  )
        
        req.httpMethod = "POST"
        req.setValue("Basic \(getBasicAuthWithusernamePassword(username: credentials.username, password: credentials.password))", forHTTPHeaderField: "Authorization")
        req.httpBody = body
        
        let (res , resErr) = await HttpHandler.request(req as URLRequest)
        if let err = resErr {
            LogManager.shared.error(err.localizedDescription)
            return false
        }
        
        let (decode , decodeErr) = JSONCoder.decodeJson(data: res!)
        if let decodeErr = decodeErr {
            LogManager.shared.error(decodeErr.localizedDescription)
            return false
        }
        
        let status = decode["order_status"] as? String  ?? ""
        
        if status.lowercased() == "success" {
            return true
        }else{
            return false
        }
        
        
//        AF.upload(
//            body ?? .init(),
//            to: mipsNetworkURl.paymentConfirmationUrl ,
//            method: .post ,
//            headers: .init([
//                .init(
//                    name: "Authorization",
//                    value: "Basic \(getBasicAuthWithusernamePassword(username: credentials.username, password: credentials.password))"
//                )
//            ])
//        )
//        .response { afData in
//            if let error = afData.error {
//                errorHandler(error.localizedDescription)
//                return
//            }
//            guard let data = afData.data
//            else{
//                errorHandler("no data found from server")
//                return
//            }
//            let (json , err) = JSONCoder.decodeJson(data: data)
//            if let err = err {
//                errorHandler(err.localizedDescription)
//                return
//            }
//            let status = json["order_status"] as? String  ?? ""
//            if status.lowercased() == "success" {
//                completion(true)
//                return
//            }
//            completion(false)
//        }
    }
    
    
    
    private static func getBasicAuthWithusernamePassword(username : String , password : String) -> String {
        let credentials = "\(username):\(password)"
        if let credentialsData = credentials.data(using: .utf8) {
            let base64Credentials = credentialsData.base64EncodedString()
            return base64Credentials
        }
        return ""
    }
    
    public static func getPaymentUrl(
        networkURL: MipsNetworkUrls ,
        merchant : MerchantDetails ,
        credentials : MerchantCredentials ,
        amount : Amount ,
        orderID : String
    ) async -> URL? {


        let json : [String : Any] = [
            "authentify" : [
                "id_merchant" : merchant.sIdMerchant ,
                "id_entity" : merchant.id_entity ,
                "id_operator" : merchant.id_operator ,
                "operator_password" : merchant.operator_password
            ] ,
            "order" : [
                "id_order" : orderID ,
                "currency" : amount.currency.rawValue ,
                "amount" : amount.price
            ] ,
            "iframe_behavior" : [
                "custom_redirection_url" : "" ,
                "language" : "EN"
            ] ,
            "request_mode" : "simple" ,
            "touchpoint" : "native_app"
        ]
        let (body , bodyError) = JSONCoder.encodeJson(json: json)
        if let bodyError = bodyError {
            LogManager.shared.error(bodyError.localizedDescription)
            return nil
        }
        let req = NSMutableURLRequest(url: URL(string: networkURL.paymentUrlGenerator)!  )
        req.httpBody = body
        req.httpMethod = "POST"
        req.setValue("Basic \(getBasicAuthWithusernamePassword(username: credentials.username, password: credentials.password))", forHTTPHeaderField: "Authorization")
        
        let (res , err) = await HttpHandler.request(req as URLRequest)
        if let err = err {
            LogManager.shared.error(err.localizedDescription)
            return nil
        }
        
        let (decode , decodeErr) = JSONCoder.decodeJson(data: res!)
        if let decodeErr = decodeErr {
            LogManager.shared.error(decodeErr.localizedDescription)
            return nil
        }
        guard let answer = decode["answer"] as? [String : Any],
              let operation_status = answer["operation_status"] as? String ,
              operation_status.lowercased() == "success".lowercased() ,
              let payment_zone_data = answer["payment_zone_data"] as? String ,
              let finalUrl = URL(string: payment_zone_data)
        else {
            LogManager.shared.error("unable to get payment url")
            return nil
        }
            
        return finalUrl
    }
}
