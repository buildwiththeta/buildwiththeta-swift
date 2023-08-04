//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 02/08/23.
//

import Foundation
import SwiftyJSON

struct GetComponentResponse {
    let componentID: String
    let treeNodes: CNode
    let conversionEvents: [ConversionEvent]
    let abTestID: String?
    
    init(json: JSON) throws {
        let decoder = JSONDecoder()
        let rendering = NodeRendering()
        
        self.componentID = json["page_id"].string!
        self.abTestID = json["ab_test"].string!

        // Decode ConversionEvent
        let conversionEventsData = try json["conversion_events"].rawData()
        self.conversionEvents = try decoder.decode([ConversionEvent].self, from: conversionEventsData)
        
        // Decode Nodes
        let nodesData = try json["nodes"].rawData()
        let nodes = try decoder.decode([CNode].self, from: nodesData)
        self.treeNodes = try rendering.renderTree(rendering.renderComponents(nodes, pageID: json["page_id"].string!))
    }
}
