//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 03/08/23.
//

import Foundation

struct RuntimeError: LocalizedError {
    let description: String

    init(_ description: String) {
        self.description = description
    }

    var errorDescription: String? {
        description
    }
}
