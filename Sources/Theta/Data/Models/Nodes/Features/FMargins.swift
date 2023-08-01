//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 31/07/23.
//

import Foundation
import SwiftUI

struct FMargins: Decodable {
    let mobile: [Double]
    let tablet: [Double]
    let desktop: [Double]
    
    init(mobile: [Double], tablet: [Double], desktop: [Double]) {
        self.mobile = mobile
        self.tablet = tablet
        self.desktop = desktop
    }
    
    func _getSingle(values: [Double]) -> EdgeInsets {
        return EdgeInsets(
            top: abs(values[1]),
            leading: abs(values[0]),
            bottom: abs(values[3]),
            trailing: abs(values[2])
        )
    }
    
    func get(device: DeviceType) -> EdgeInsets {
        switch (device) {
            case .mobile:
                return _getSingle(values: mobile)
            case .tablet:
                return _getSingle(values: tablet)
            default:
                return _getSingle(values: desktop)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case mobile = "m"
        case tablet = "t"
        case desktop = "d"
    }
}
