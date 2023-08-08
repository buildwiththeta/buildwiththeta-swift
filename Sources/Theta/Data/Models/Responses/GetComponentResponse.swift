//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 02/08/23.
//

import Foundation
import SwiftyJSON
import Swinject

struct GetComponentResponse {
    let componentID: String
    let treeNodes: CNode
    let conversionEvents: [ConversionEvent]
    let abTestID: String?
    
    let nodesData: Any
    
    init(json: JSON) throws {
        let decoder = JSONDecoder()
        let container = Container()
        let rendering = container.resolve(NodeRendering.self)!
        
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
        self.nodesData = nodesData
        
        self.treeNodes = try rendering.renderTree(rendering.renderComponents(nodes, pageID: json["page_id"].string!))
        print(self.treeNodes)
    }
    
    func toJson() -> [String: Any?] {
        return [
            "page_id": componentID,
            "ab_test": abTestID,
            "conversion_events": conversionEvents.map { $0.toJson() },
            "nodes": nodesData,
        ]
    }
}
