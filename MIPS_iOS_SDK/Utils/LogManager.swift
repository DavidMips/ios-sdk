//
//  LogManager.swift
//  MIPS_iOS_SDK
//
//  Created by shyank on 30/04/24.
//

import Foundation


public final class LogManager {
    
    public static let shared = LogManager()
    
    private init() {}
    
    public func info(_ msg : String) {
        let log = "☘️ \(msg)"
        NSLog(log)
    }
    
    public func error(_ msg : String) {
        let log = "🚨 \(msg)"
        NSLog(log)
    }
}
