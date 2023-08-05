//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 02/08/23.
//

import Foundation
import SwiftUI

enum FFillType: String, Decodable {
    case solid = "s"
    case linearGradient = "l"
    case radialGradient = "r"
    case style = "st"
    case image = "i"
    case none = "n"
}

struct FFill: Decodable {
    let levels: [FFillElement]?
    let type: FFillType?
    let begin: CAlignment?
    let end: CAlignment?
    let center: CAlignment?
    let radius: Double?
    let boxFit: String?
    let paletteStyle: String?
    
    init(levels: [FFillElement], type: FFillType, begin: CAlignment?, end: CAlignment?, center: CAlignment?, radius: Double?, boxFit: String?, paletteStyle: String?) {
        self.levels = levels
        self.type = type
        self.begin = begin
        self.end = end
        self.center = center
        self.radius = radius
        self.boxFit = boxFit
        self.paletteStyle = paletteStyle
    }
    
    func getHexColor() -> Color {
        return Color(hex: levels?.first?.color ?? "000000")
    }
    
    enum CodingKeys: String, CodingKey {
        case levels = "l"
        case type = "t"
        case begin = "b"
        case end = "e"
        case center = "c"
        case radius = "r"
        case boxFit = "bF"
        case paletteStyle = "pltt"
    }
}

struct FFillElement: Decodable {
    let color: String
    let opacity: Double
    let stop: Double
    
    init(color: String, opacity: Double, stop: Double) {
        self.color = color
        self.opacity = opacity
        self.stop = stop
    }
}
