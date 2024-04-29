//
//  String+Extension.swift
//  MIPS_iOS_SDK
//
//  Created by shyank on 30/04/24.
//

import Foundation
import CryptoSwift
import CommonCrypto

public extension String {
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return stringData.sha256()
        }
        return ""
    }
}



extension Data{
    public func sha256() -> String{
        
        return hexStringFromData(input: digest(input: self as NSData))
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
}



extension String {
    func aesEncrypt(key: String) throws -> String {
        
        var result = ""
        
        do {
            
            let key: [UInt8] = Array(key.utf8) as [UInt8]
            
            let aes = try! AES(key: key, blockMode: ECB() , padding:.pkcs5 ) // AES128 .ECB pkcs7
            
            let encrypted = try aes.encrypt(Array(self.utf8))
            
            result = encrypted.toBase64()
            
            
            print("AES Encryption Result: \(result)")
            
        } catch {
            
            print("Error: \(error)")
        }
        
        return result
    }
    
    func aesDecrypt(key: String) throws -> String {
        
        var result = ""
        
        do {
            
            let encrypted = self
            let key: [UInt8] = Array(key.utf8) as [UInt8]
            let aes = try! AES(key: key, blockMode: ECB(), padding: .pkcs5) // AES128 .ECB pkcs7
            let decrypted = try aes.decrypt(Array(base64: encrypted))
            
            result = String(data: Data(decrypted), encoding: .utf8) ?? ""
            
            print("AES Decryption Result: \(result)")
            
        } catch {
            
            print("Error: \(error)")
        }
        
        return result
    }
    
}


extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
}
