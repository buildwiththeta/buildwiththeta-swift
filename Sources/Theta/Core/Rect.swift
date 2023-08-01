//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 01/08/23.
//

import Foundation

struct Rect: Decodable {
    let left: Double
    let top: Double
    let right: Double
    let bottom: Double

    func width() -> Double {
        return right - left
    }
    
    func height() -> Double {
        return bottom - top
    }
}
