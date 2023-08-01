//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 29/07/23.
//

import Foundation
import UIKit

struct FSize: Decodable {
    let mobile: String
    let tablet: String
    let desktop: String
    
    init(mobile: String, tablet: String, desktop: String) {
        self.mobile = mobile
        self.tablet = tablet
        self.desktop = desktop
    }
    
    func get(device: DeviceType, isWidth: Bool) -> Double? {
        var value: String?
        switch device {
            case .mobile:
                value = mobile
            case .tablet:
                value = tablet
            default:
                value = desktop
        }
        

        if value?.lowercased() == "max" ||
            value?.lowercased() == "inf" ||
            value?.lowercased() == "100%" {
            return Double.greatestFiniteMagnitude
        } else if value?.lowercased() == "null" || value?.lowercased() == "auto" {
            return nil
        }
        let temp = value!.replacingOccurrences(of: "%", with: "")
        if let valueDouble = Double(temp) {
            if value!.contains("%") {
                let side: Double
                if isWidth {
                    side = Double(UIScreen.main.bounds.size.width)
                } else {
                    side = Double(UIScreen.main.bounds.size.height)
                }
                return Double(side) * (valueDouble / 100)
            }
            return valueDouble
        }
        return 0
    }
    
    enum CodingKeys: String, CodingKey {
        case mobile = "s"
        case tablet = "t"
        case desktop = "d"
    }
}
