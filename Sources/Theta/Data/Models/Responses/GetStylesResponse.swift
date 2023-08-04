//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 02/08/23.
//

import Foundation
import SwiftyJSON

struct GetStylesResponse {
    let colorStyles: [ColorStyle]
    let textStyles: [TextStyle]

    init(json: JSON) throws {
        let decoder = JSONDecoder()

        // Decode ColorStyles
        let colorStylesData = try json["colors"].rawData()
        self.colorStyles = try decoder.decode([ColorStyle].self, from: colorStylesData)

        // Decode TextStyles
        let textStylesData = try json["texts"].rawData()
        self.textStyles = try decoder.decode([TextStyle].self, from: textStylesData)
    }
}

