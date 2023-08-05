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
        self.abTestID = json["ab_test"].string

        // Decode ConversionEvent
        let conversionEventsData = try json["conversion_events"].rawData()
        self.conversionEvents = try decoder.decode([ConversionEvent].self, from: conversionEventsData)
        
        // Decode Nodes
        let nodesData = json["nodes"].arrayValue
        var nodes: [CNode] = []
        
        for rawNode in nodesData {
            let newNode = try CNode(json: rawNode)
            nodes.append(newNode)
            print("\(newNode.type) \(newNode.attributes)")
        }
        
        self.treeNodes = try rendering.renderTree(rendering.renderComponents(nodes, pageID: json["page_id"].string!))
        print(self.treeNodes)
    }
}
