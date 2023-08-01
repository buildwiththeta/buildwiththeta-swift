//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 01/08/23.
//

import Foundation
import SwiftUI

struct FBorderRadius: Decodable {
    let mobile: [Double]
    let tablet: [Double]
    let desktop: [Double]
    
    init(mobile: [Double], tablet: [Double], desktop: [Double]) {
        self.mobile = mobile
        self.tablet = tablet
        self.desktop = desktop
    }
    
    func get() -> RoundedRectangle {
        return RoundedRectangle(cornerRadius: mobile.first!)
    }
    
    enum CodingKeys: String, CodingKey {
        case mobile = "m"
        case tablet = "t"
        case desktop = "d"
    }
}
