//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 05/08/23.
//

import Foundation

struct NodeAttributes : Decodable {
    let align: FAlign?
    let width: FSize?
    let height: FSize?
    let boxFit: BoxFitEnum?
    let margins: FMargins?
    let padding: FMargins?
    let borderRadius: FBorderRadius?
    let text: FTextTypeInput?
    let image: FTextTypeInput?
    let fill: FFill?
    let icon: String?
    let visibleOnMobile: Bool?
    let visibleOnTablet: Bool?
    let visibleOnLaptop: Bool?
    let visibleOnDesktop: Bool?
    let mainAxisAlignment: MainAxisAlignment?
    let crossAxisAlignment: CrossAxisAlignment?
    
    enum CodingKeys: String, CodingKey {
        case align = "al"
        case width = "wdh"
        case height = "hgh"
        case boxFit = "bxF"
        case margins = "m"
        case padding = "p"
        case borderRadius = "bR"
        case text = "v"
        case image = "img"
        case fill = "fill"
        case icon = "icn"
        case visibleOnMobile = "vOM"
        case visibleOnTablet = "vOT"
        case visibleOnLaptop = "vOL"
        case visibleOnDesktop = "vOD"
        case mainAxisAlignment = "mAA"
        case crossAxisAlignment = "cAA"
    }
}
