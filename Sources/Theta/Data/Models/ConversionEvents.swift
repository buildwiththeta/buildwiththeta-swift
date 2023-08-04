//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 03/08/23.
//

import Foundation

struct ConversionEvent: Decodable {
    let id: String
    let nodeID: String
    let projectID: String
    let trigger: Trigger
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case nodeID = "node_id"
        case projectID = "project_id"
        case trigger = "trigger"
        case createdAt = "created_at"
    }
}
