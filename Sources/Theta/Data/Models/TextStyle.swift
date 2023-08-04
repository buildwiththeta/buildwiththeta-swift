//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 02/08/23.
//

import Foundation

struct TextStyle: Decodable {
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

struct TextStyleProperties: Decodable {
    let fontFamily: String
    let fontSize: String
    let fontWeight: String
    
    init(fontFamily: String, fontSize: String, fontWeight: String) {
        self.fontFamily = fontFamily
        self.fontSize = fontSize
        self.fontWeight = fontWeight
    }
    
    enum CodingKeys: String, CodingKey {
        case fontFamily = "family"
        case fontSize = "size"
        case fontWeight = "weight"
    }
}
