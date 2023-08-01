//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 01/08/23.
//

import Foundation

struct RectProperties: Decodable {
    let rect: ResponsiveRect
    let flipRectWhileResizing: Bool
    let flipChild: Bool
    let constraintsEnabled: Bool
    let resizable: Bool
    let movable: Bool
    let hideHandlesWhenNotResizable: Bool
    let verticalAlign: ResponsiveAlignment
    let horizontalAlign: ResponsiveAlignment
    
    enum CodingKeys: String, CodingKey {
        case rect = "rect"
        case flipRectWhileResizing = "flipRectWhileResizing"
        case flipChild = "flipChild"
        case constraintsEnabled = "constraintsEnabled"
        case resizable = "resizable"
        case movable = "movable"
        case hideHandlesWhenNotResizable = "hideHandlesWhenNotResizable"
        case verticalAlign = "vertical_align"
        case horizontalAlign = "horizontal_align"
    }
}
