//
//  HttpHandler.swift
//  MIPS_iOS_SDK
//
//  Created by shyank on 03/06/24.
//

import Foundation


public class HttpHandler {
    
    public static func request(
        _ req : URLRequest
    ) async  -> (Data? , Error?) {
        return await withCheckedContinuation { continuation in
            URLSession.shared.dataTask(
                with: req
            ) { data, responce, err in
                if let err = err {
                    return continuation.resume(returning: (nil , err))
                }
                guard let httpResponce = responce as? HTTPURLResponse
                else {
                    return continuation.resume(returning: (nil , NSError(domain: "bad status code", code: 0, userInfo: nil)  ))
                }
                let statusCode = httpResponce.statusCode
                
                guard (200...299).contains(statusCode)
                else {
                    return continuation.resume(returning: (nil , NSError(domain: "\(statusCode) status code got from network call", code: 1, userInfo: nil) ))
                }
                guard let data = data 
                else{
                    return continuation.resume(returning: (nil , NSError(domain: "empty body got from network request", code: 2, userInfo: nil) ))
                }
                return continuation.resume(returning: (data , nil))
            }
        }
    }
}
