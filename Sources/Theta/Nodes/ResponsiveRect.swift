//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 01/08/23.
//

import Foundation
import SwiftUI

struct ResponsiveRect: Decodable {
    let rectPhone: Rect
    let rectTablet: Rect?
    let rectLaptop: Rect?
    let rectDesktop: Rect?
    
    func get(deviceType: DeviceType) -> Rect {
        switch deviceType {
            case .mobile:
                return rectPhone
            case .tablet:
                return rectTablet != nil ? rectTablet! : rectPhone
            case .laptop:
                return rectLaptop != nil ? rectLaptop! : rectDesktop != nil ? rectDesktop! : rectPhone
            case .desktop:
                return rectDesktop != nil ? rectDesktop! : rectPhone
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case rectPhone = "phone"
        case rectTablet = "tablet"
        case rectLaptop = "laptop"
        case rectDesktop = "desktop"
    }
}
