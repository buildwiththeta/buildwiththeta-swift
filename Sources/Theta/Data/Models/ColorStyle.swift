//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 02/08/23.
//

import Foundation

struct ColorStyle: Decodable {
    let id: String
    let branchID: String
    let name: String
    let stabilID: String?
    let properties: ColorStyleProperties
    
    init(id: String, branchID: String, name: String, stabilID: String, properties: ColorStyleProperties) {
        self.id = id
        self.branchID = branchID
        self.name = name
        self.stabilID = stabilID
        self.properties = properties
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case branchID = "branch_id"
        case name = "name"
        case stabilID = "stabil_id"
        case properties = "properties"
    }
}

struct ColorStyleProperties: Decodable {
    let light: FFill
    let dark: FFill
    
    init(light: FFill, dark: FFill) {
        self.light = light
        self.dark = dark
    }
    
    enum CodingKeys: String, CodingKey {
        case light = "light"
        case dark = "value"
    }
}
