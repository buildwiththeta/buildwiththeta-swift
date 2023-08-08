//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 07/08/23.
//

import Foundation

class PreloadFile {
    let enabled: Bool
    let customJson: [String: Any]?

    init(enabled: Bool, customJson: [String: Any]?) {
        self.enabled = enabled
        self.customJson = customJson
    }
}
