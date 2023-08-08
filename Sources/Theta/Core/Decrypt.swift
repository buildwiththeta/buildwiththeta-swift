//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 07/08/23.
//

import Foundation
import Crypto

func decompressAndDecrypt(_ anonKey: String, encryptedBase64: String) -> String? {
    // Extracting the key from anonKey
    let keySegment = anonKey.split(separator: ".")[1]
    let keyString = String(keySegment.prefix(32))
    
    guard let keyData = keyString.data(using: .utf8),
          let encryptedData = Data(base64Encoded: encryptedBase64) else {
        return nil
    }

    // Create a symmetric key
    let symmetricKey = SymmetricKey(data: keyData)

    // Decrypt
    let decryptedData: Data
    do {
        decryptedData = try AES.GCM.decrypt(encryptedData, using: symmetricKey)
    } catch {
        print("Decryption failed: \(error)")
        return nil
    }

    // Decompress using zlib
    guard let decompressedData = decompress(data: decryptedData) else {
        return nil
    }

    return String(data: decompressedData, encoding: .utf8)
}

func decompress(data: Data) -> Data? {
    guard data.count > 4 else {
        return nil
    }
    
    var size: UInt32 = 0
    _ = withUnsafeMutableBytes(of: &size) {
        data.subdata(in: 0..<4).copyBytes(to: $0)
    }
    
    guard let decompressedData = NSMutableData(length: Int(size)) else {
        return nil
    }
    
    var stream = z_stream()
    stream.next_in = (data as NSData).bytes.bindMemory(to: Bytef.self, capacity: data.count)
    stream.avail_in = uint(data.count)
    stream.next_out = decompressedData.mutableBytes.bindMemory(to: Bytef.self, capacity: decompressedData.length)
    stream.avail_out = uint(decompressedData.length)
    
    if inflateInit2_(&stream, MAX_WBITS + 32, ZLIB_VERSION, Int32(MemoryLayout<z_stream>.stride)) != Z_OK {
        return nil
    }
    
    if inflate(&stream, Z_FINISH) != Z_STREAM_END {
        inflateEnd(&stream)
        return nil
    }
    
    inflateEnd(&stream)
    return decompressedData as Data
}
