//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 31/07/23.
//

import Foundation
import SwiftUI

struct FTextAlign: Decodable {
    let align: String
    
    func get() -> TextAlignment {
        switch align {
            case "center":
                return TextAlignment.center
            case "left":
                return TextAlignment.leading
            case "right":
                return TextAlignment.trailing
            default:
                return TextAlignment.center
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case align = "txtAlg"
    }
}
