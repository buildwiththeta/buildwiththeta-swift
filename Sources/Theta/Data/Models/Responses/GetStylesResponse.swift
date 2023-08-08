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
    
    let colorStylesData: Any
    let textStylesData: Any

    init(json: JSON) throws {
        let decoder = JSONDecoder()

        // Decode ColorStyles
        let colorStylesData = try json["colors"].rawData()
        self.colorStylesData = colorStylesData
        self.colorStyles = try decoder.decode([ColorStyle].self, from: colorStylesData)

        // Decode TextStyles
        let textStylesData = try json["texts"].rawData()
        self.textStylesData = textStylesData
        self.textStyles = try decoder.decode([TextStyle].self, from: textStylesData)
    }
    
    func toJson() -> [String: Any?] {
        return [
            "colors": colorStylesData,
            "texts": textStylesData,
        ]
    }
}

