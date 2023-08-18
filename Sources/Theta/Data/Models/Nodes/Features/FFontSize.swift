//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 01/08/23.
//

import Foundation
import SwiftUI

struct FFontSize: Decodable {
    let mobile: Double
    let tablet: Double
    let desktop: Double
    
    init(mobile: Double, tablet: Double, desktop: Double) {
        self.mobile = mobile
        self.tablet = tablet
        self.desktop = desktop
    }
    
    func get(device: DeviceType) -> Double {
        switch device {
            case .mobile:
                return mobile
            case .tablet:
                return tablet
            default:
                return desktop
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case mobile = "s"
        case tablet = "st"
        case desktop = "sd"
    }
}
