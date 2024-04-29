//
//  JSONCoder.swift
//  MIPS_iOS_SDK
//
//  Created by shyank on 30/04/24.
//

import Foundation



public class JSONCoder {
    
    public static func decodeJson<T : Decodable>(
        model : T.Type ,
        data : Data
    ) -> (T? , Error?) {
        do {
            let decodedJson = try JSONDecoder().decode(model, from: data)
            return (decodedJson , nil)
        } catch  {
            return (nil , error)
        }
    }
    
    public static func encodeJso<T : Encodable>(
        json : T
    ) -> (Data? , Error?) {
        do {
            let data = try JSONEncoder().encode(json)
            return (data , nil)
        } catch  {
            return (nil , error)
        }
    }
    
    public static func encodeJson(json : [String : Any]) -> (Data? , Error?) {
        do {
            let json = try JSONSerialization.data(withJSONObject: json)
            return  (json ,  nil)
        } catch  {
            return ( nil , error)
        }
    }
    
    public static func decodeJson(data : Data) -> ([String : Any] , Error?) {
        do {
            let data = try JSONSerialization.jsonObject(with: data)
            guard let jsonDict = data as? [String : Any]
            else {
                let error = NSError(domain: "json not in dictionary structure", code: 0)
                return ([:] ,error)
            }
            return (jsonDict , nil)
        } catch  {
            return ([:] , error)
        }
    }
}
