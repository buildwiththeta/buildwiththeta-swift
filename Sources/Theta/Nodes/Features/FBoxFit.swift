//
//  File.swift
//
//
//  Created by Andrea Buttarelli on 01/08/23.
//

import Foundation
import SwiftUI

struct FBoxFit: Decodable {
    let fit: String
    
    init(fit: String) {
        self.fit = fit
    }
    
    func get() -> ContentMode {
        switch fit {
            case "fit":
                return ContentMode.fit
            case "cover":
                return ContentMode.fill
            default:
                return ContentMode.fill
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case fit = "bxF"
    }
}

