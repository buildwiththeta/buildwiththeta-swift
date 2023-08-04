//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 02/08/23.
//

import Foundation

enum FFillType: String, Decodable {
    case solid
    case linearGradient
    case radialGradient
    case style
    case image
    case none
}

struct FFill: Decodable {
    let levels: [FFillElement]
    let type: FFillType
    let begin: CAlignment?
    let end: CAlignment?
    let center: CAlignment?
    let radius: Double?
    let boxFit: FBoxFit?
    let paletteStyle: String?
    
    init(levels: [FFillElement], type: FFillType, begin: CAlignment?, end: CAlignment?, center: CAlignment?, radius: Double?, boxFit: FBoxFit?, paletteStyle: String?) {
        self.levels = levels
        self.type = type
        self.begin = begin
        self.end = end
        self.center = center
        self.radius = radius
        self.boxFit = boxFit
        self.paletteStyle = paletteStyle
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
