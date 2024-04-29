//
//  LogManager.swift
//  MIPS_iOS_SDK
//
//  Created by shyank on 30/04/24.
//

import Foundation
import CocoaLumberjack


public final class LogManager {
    
    public static let shared = LogManager()
    
    private init() {
        DDLog.add(DDOSLogger.sharedInstance)
        if let console = DDTTYLogger.sharedInstance {
            DDLog.add(console   )
        }
        
    }
    
    public func info(_ msg : String) {
        let log = "☘️ \(msg)"
        let msgFormat = DDLogMessageFormat(stringLiteral: log)
        DDLogInfo(msgFormat)
    }
    
    public func error(_ msg : String) {
        let log = "🚨 \(msg)"
        let msgFormat = DDLogMessageFormat(stringLiteral: log)
        DDLogError(msgFormat)
    }
}
