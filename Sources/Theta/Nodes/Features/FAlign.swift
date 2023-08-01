//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 01/08/23.
//

import Foundation

struct FAlign: Decodable {
    let align: String
    
    init(alignment: String) {
        self.align = alignment
    }
    
    enum CodingKeys: String, CodingKey {
        case align = "m"
    }
}
