//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 03/08/23.
//

import Foundation

enum Trigger: String, Decodable {
    case onTap = "On Tap"
    case onLongPress = "On Long Press"
    case onDoubleTap = "On Double Tap"
    case onHoverTrigger = "On Hover"
    case onMouseEnter = "On Mouse Enter"
    case onMouseExit = "On Mouse Exit"
}
