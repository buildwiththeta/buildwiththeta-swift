//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 01/08/23.
//

import Foundation
import SwiftUI

struct FAlign: Decodable {
    let align: CAlignment
    
    init(alignment: CAlignment) {
        self.align = alignment
    }
    
    func get() -> Alignment {
        switch align {
            case .tL:
                return Alignment.topLeading
            case .tC:
                return Alignment.top
            case .tR:
                return Alignment.topTrailing
            case .cL:
                return Alignment.leading
            case .c:
                return Alignment.center
            case .cR:
                return Alignment.trailing
            case .bL:
                return Alignment.bottomLeading
            case .bC:
                return Alignment.bottom
            case .bR:
                return Alignment.bottomTrailing
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case align = "m"
    }
}
