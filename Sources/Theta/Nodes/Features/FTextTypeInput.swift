//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 31/07/23.
//

import Foundation

struct FTextTypeInput: Decodable {
    let mobile: String
    let tablet: String
    let laptop: String
    let desktop: String
    
    init(mobile: String, tablet: String, laptop: String, desktop: String) {
        self.mobile = mobile
        self.tablet = tablet
        self.laptop = laptop
        self.desktop = desktop
    }
    
    func get(device: DeviceType) -> String {
        switch (device) {
            case .mobile:
                return mobile
            case .tablet:
                return tablet
        case .laptop:
                return laptop
            default:
                return desktop
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case mobile = "v"
        case tablet = "vt"
        case laptop = "vl"
        case desktop = "vd"
    }
}
